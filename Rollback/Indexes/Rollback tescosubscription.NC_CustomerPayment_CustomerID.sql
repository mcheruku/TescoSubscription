/*
      Created By:       Saritha Kommineni
      Date created:     20 Sep 2011
      Purpose:          ROLLBACK script for tescosubscription.NC_CustomerPayment_CustomerID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPayment', N'U') 
AND [name] = N'tescosubscription.NC_CustomerPayment_CustomerID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPayment.[tescosubscription.NC_CustomerPayment_CustomerID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPayment', N'U') 
                                                            AND [name] = N'tescosubscription.NC_CustomerPayment_CustomerID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[tescosubscription.NC_CustomerPayment_CustomerID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[tescosubscription.NC_CustomerPayment_CustomerID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[tescosubscription.NC_CustomerPayment_CustomerID] does not exist.'
            END
GO