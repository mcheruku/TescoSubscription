/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_PaymentProcessStatus] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_PaymentProcessStatus') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_PaymentProcessStatus] 
                    ON [tescosubscription].[CustomerSubscription] ([PaymentProcessStatus] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_PaymentProcessStatus') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_PaymentProcessStatus] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_PaymentProcessStatus] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_PaymentProcessStatus] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
