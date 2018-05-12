/*

Author:     Robin
Created:    26 May 2014
Purpose:    Create index   [NC_CustomerPayment_PaymentToken] on [tescosubscription].[CustomerPayment]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]', N'U')
                   AND   [name] = N'NC_CustomerPayment_PaymentToken') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPayment_PaymentToken] 
                    ON [tescosubscription].[CustomerPayment] ([PaymentToken] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U')
                                 AND   [name] = N'NC_CustomerPayment_PaymentToken') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPayment_PaymentToken] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPayment_PaymentToken] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPayment_PaymentToken] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPayment] does not exist.',16, 1)
        END

GO
