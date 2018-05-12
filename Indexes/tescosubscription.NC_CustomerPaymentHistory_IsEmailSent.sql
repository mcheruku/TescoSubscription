/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerPaymentHistory_IsEmailSent] on [tescosubscription].[CustomerPaymentHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistory_IsEmailSent') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistory_IsEmailSent] 
                    ON [tescosubscription].[CustomerPaymentHistory] ([IsEmailSent] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistory_IsEmailSent') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistory_IsEmailSent] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistory_IsEmailSent] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistory_IsEmailSent] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistory] does not exist.',16, 1)
        END

GO
