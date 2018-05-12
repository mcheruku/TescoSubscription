/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


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


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] 
                    ON [tescosubscription].[CustomerSubscription] ([SubscriptionStatus] ASC ,[NextRenewalDate] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
