/*

Author:     Saritha Kommineni
Created:    06 Jan 2012
Purpose:    Create index   [NC_CustomerPaymentHistory_IsEmailSent] on [tescosubscription].[CustomerPaymentHistoryResponse]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] 
                    ON [tescosubscription].[CustomerPaymentHistoryResponse] ([CustomerPaymentHistoryID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID') 
                            BEGIN

                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID]  not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID]  already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16, 1)
        END

GO
