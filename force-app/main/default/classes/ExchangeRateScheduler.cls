/**
 * @description Scheduler class to run the exchange rate update on a schedule
 * Scheduling should be done in Salesforce Setup Apex Classes -> Schedule Apex
 */
global class ExchangeRateScheduler implements Schedulable {
    
    /**
     * @description Executes the scheduled job to update exchange rates
     * @param context The SchedulableContext
     */
    global void execute(SchedulableContext SC) {
        // REVISIT: 3. Consider adding logging if available
        try {
            List<Exchange_Rate__c> updatedRates = ExchangeRateService.updateExchangeRates();
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}