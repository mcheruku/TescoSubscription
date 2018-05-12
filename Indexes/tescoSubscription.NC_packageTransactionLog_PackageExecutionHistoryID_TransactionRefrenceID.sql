/*

Author:     Saritha Kommineni
Created:    04 Oct 2011
Purpose:    Create index   [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] on [tescosubscription].[packageTransactionLog]

       --Modifications History--
Changed On        Changed By        Defect         Change Description


*/

IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[packageTransactionLog]', N'U')
                   AND   [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] 
                    ON [tescosubscription].[packageTransactionLog] ([PackageExecutionHistoryID] ASC,[TransactionRefrenceID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U')
                                 AND   [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[packageTransactionLog] does not exist.',16, 1)
        END

GO
