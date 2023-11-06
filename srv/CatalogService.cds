using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';


service CatalogService @(path: 'CatalogService'){
    //In odata service an entityset is used as end point to perform
    //CURDQ - Create Update Read Delete and Query operations
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity EmployeeSet as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity BPAddress as projection on master.address;

    entity POs @(
        odata.draft.enabled: true
    ) as projection on transaction.purchaseorder{
        *,
     @title : 'Gross Amount'
        ROUND(GROSS_AMOUNT,0) as GROSS_AMOUNT: Int64,
        Items,
        @title : '{i18n>OVERALL_STATUS}'
        case OVERALL_STATUS
            when 'A' then 'Approved'
            when 'P' then 'Pending'
            when 'N' then 'New'
            when 'X' then 'Rejected'
            when 'D' then 'Delivered'
            else 'Nothing'
            end as OVERALL_STATUS : String(10),
        case OVERALL_STATUS
            when 'A' then 3
            when 'P' then 2
            when 'N' then 2
            when 'X' then 1
            else 4
            end as Spiderman : Int16   
    }
    
   actions{
        @cds.odata.bindingparameter.name : '_refreshedVal'
        @Common.SideEffects : {
                TargetProperties : ['_refreshedVal/GROSS_AMOUNT']
                //TargetProperties: ['_refreshedVal/OVERALL_STATUS']
            } 

        action boost();
        action setOrderProcessing();
        function largestOrder() returns array of POs;
        function getOrderDefaults() returns POs;
    };

    entity POItems as projection on transaction.poitems;
    
}

