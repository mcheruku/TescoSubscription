/*
      Created By:      Robin
      Date created:     27 jun 2013
      Purpose:          ROLLBACK script for NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate] not dropped.',16,1)
                                    END
            END



IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_NextPaymentDate')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_NextPaymentDate]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_NextPaymentDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerSubscription_NextPaymentDate] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerSubscription_NextPaymentDate] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerSubscription_NextPaymentDate] does not exist.'
            END

GO