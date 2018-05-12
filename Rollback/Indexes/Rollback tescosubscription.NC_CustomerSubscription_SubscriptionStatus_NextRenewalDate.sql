/*
      Created By:       Saritha Kommineni
      Date created:     04 Oct 2011
      Purpose:          ROLLBACK script for NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] does not exist.'
            END
GO