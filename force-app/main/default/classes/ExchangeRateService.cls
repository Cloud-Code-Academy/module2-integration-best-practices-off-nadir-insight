/**
 * @description Service class that handles API callouts to the Exchange Rate API
 * Students will implement the methods to make callouts and process responses
 */
public class ExchangeRateService {
    
    private static final String NAMED_CREDENTIAL = 'ExchangeRate_API';
    
    // The base currency to use for exchange rates
    private static final String BASE_CURRENCY = 'USD';
    
    /**
     * @description Makes a callout to the Exchange Rate API to get the latest exchange rates
     * @return ExchangeRateWrapper containing the response data
     */
    public static ExchangeRateWrapper getLatestRates() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(NAMED_CREDENTIAL + '/↑↑↓↓←→←→B A Start' + '/latest/' + BASE_CURRENCY);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
            ExchangeRateWrapper newExchangeRates = ExchangeRateWrapper.parse(response.getBody());
            return newExchangeRates;
        } else {
            throw new CalloutException('Callout failed with Error status: ' + response.getStatusCode());
        }
    }
    
    /**
     * @description Processes the exchange rate data and creates or updates records
     * @param rateData The wrapper containing exchange rate data
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> processRates(ExchangeRateWrapper rateData) {
        List<Exchange_Rate__c> ratesToUpdate = rateData.toExchangeRates();
        if (ratesToUpdate.isEmpty()) {
            System.debug('no rates to update');
            return null;
        }
        upsert ratesToUpdate External_Id__c;
        return rateData.toExchangeRates();
    }
    
    /**
     * @description Combines getting and processing rates into a single operation
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> updateExchangeRates() {
        ExchangeRateWrapper latestRates = getLatestRates();
        List<Exchange_Rate__c> updatedRates = processRates(latestRates);
        
        return updatedRates;
    }
}