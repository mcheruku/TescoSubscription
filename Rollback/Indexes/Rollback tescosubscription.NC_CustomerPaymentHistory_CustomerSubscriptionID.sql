/*
      Created By:       Saritha Kommineni
      Date created:     20 Sep 2011
      Purpose:          ROLLBACK script for tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
AND [name] = N'tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPaymentHistory.[tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
                                                            AND [name] = N'tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[tescosubscription.NC_CustomerPaymentHistory_CustomerSubscriptionID] does not exist.'
            END
GO