/*
      Created By:       Saritha Kommineni
      Date created:     04 Oct 2011
      Purpose:          ROLLBACK script for NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.packageTransactionLog', N'U') 
AND [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID')
            BEGIN
                        DROP INDEX tescosubscription.packageTransactionLog.[NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.packageTransactionLog', N'U') 
                                                            AND [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] does not exist.'
            END
GO