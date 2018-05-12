/*
      Created By:       Saritha Kommineni
      Date created:     24 Aug 2011
      Purpose:          ROLLBACK script for NC_CustomerSubscription_CustomerID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_CustomerID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_CustomerID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_CustomerID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerSubscription_CustomerID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerSubscription_CustomerID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerSubscription_CustomerID] does not exist.'
            END
GO