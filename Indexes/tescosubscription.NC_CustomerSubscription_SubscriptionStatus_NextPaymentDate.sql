/*

Author:     Robin John
Created:    27 Jun 2013
Purpose:    Create index   [NC_CustomerSubscription_NextPaymentDate] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
2 July 2013       Robin					        Removed SubscriptionStatus in index	


*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
            BEGIN
                          
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate]


 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate not dropped.',16,1)
                                    END
            END


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_NextPaymentDate') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_NextPaymentDate] 
                    ON [tescosubscription].[CustomerSubscription] ([NextPaymentDate] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_NextPaymentDate') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_NextPaymentDate] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_NextPaymentDate] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_NextPaymentDate] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
