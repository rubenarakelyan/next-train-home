require 'savon'
require_relative 'nre_token'

class NationalRailEnquiries
  def self.get_departure_board(from:, to:)
    # All station CRS codes need to be in uppercase, otherwise they won't be recognised
    from.upcase!
    to.upcase!
    # WSDL: https://lite.realtime.nationalrail.co.uk/OpenLDBWS/wsdl.aspx?ver=2017-10-01
    client = Savon.client(
      endpoint: 'https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx',
      namespace: 'http://thalesgroup.com/RTTI/2017-10-01/ldb/',
      convert_request_keys_to: :camelcase,
    )
    response = client.call('http://thalesgroup.com/RTTI/2015-05-14/ldb/GetDepBoardWithDetails',
      xml: get_departure_board_soap_request(from, to))
    response.hash
  end

private

  def self.get_departure_board_soap_request(from, to)
    <<~SOAP_REQUEST
      <?xml version="1.0" encoding="UTF-8"?>
      <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://thalesgroup.com/RTTI/2017-10-01/ldb/" xmlns:ns2="http://thalesgroup.com/RTTI/2013-11-28/Token/types">
        <SOAP-ENV:Header>
          <ns2:AccessToken>
            <ns2:TokenValue>#{nre_token}</ns2:TokenValue>
          </ns2:AccessToken>
        </SOAP-ENV:Header>
        <SOAP-ENV:Body>
          <ns1:GetDepBoardWithDetailsRequest>
            <ns1:numRows>5</ns1:numRows>
            <ns1:crs>#{from}</ns1:crs>
            <ns1:filterCrs>#{to}</ns1:filterCrs>
            <ns1:filterType>to</ns1:filterType>
            <ns1:timeOffset>0</ns1:timeOffset>
            <ns1:timeWindow>30</ns1:timeWindow>
          </ns1:GetDepBoardWithDetailsRequest>
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
    SOAP_REQUEST
  end
end
