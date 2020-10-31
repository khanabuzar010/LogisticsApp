public  class LogisticsInvoice {
    public List<Asset> asset {get; private set;}
    public List<Location__c> location {get; private set;}
    public List<Quote> quote{get; private set;}
    public List<Grand__c> grand{get; private set;}
    public List<Decimal> decim {get; private set;}
    public decimal deci {get; private set;}
    public String loca1 {get; private set;}
    public String loca2 {get; private set;}
    public Decimal grandTotal {get; private set;}
    public Decimal location_charge {get; private set;}
    public Id RecordId {get;set;}


    public LogisticsInvoice(ApexPages.StandardController controller) {
        RecordId  = ApexPages.currentPage().getParameters().get('id');
        this.asset = [Select Name,Shipping_Number__c,Owner.Name, Account.Name,
                        Account.Pickup_Address__c, Account.Delivery_Address__c,
                        Account.Zip_Code__c,Account.Complete_Address__c,Status,Quantity,Price,Sub_Total__c,
                        Product2.Name,ProductCode, Driver__r.Name from Asset where Id = :RecordId];
        this.loca1 = asset[0].Account.Pickup_Address__c+'_'+asset[0].Account.Delivery_Address__c;
        this.loca2 = asset[0].Account.Delivery_Address__c+'_'+asset[0].Account.Pickup_Address__c;
        
        this.location = [Select Name,Location_Charge__c from Location__c where Name = :loca1 OR Name = :loca2];
        if(location[0].Name == loca1 || location[0].Name == loca2){
 		   //System.debug('data'+Location[0].Location_Charge__c);
 		   this.location_charge = location[0].Location_Charge__c;
		}
        this.grandTotal = location_charge;
        for(Integer i=0;i<asset.size();i++){
            this.grandTotal += asset[i].Sub_Total__c;
        }
        
    }
}