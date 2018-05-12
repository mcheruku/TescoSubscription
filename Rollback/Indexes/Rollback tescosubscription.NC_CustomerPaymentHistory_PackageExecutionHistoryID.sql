/*
      Created By:       Saritha Kommineni
      Date created:     24 Aug 2011
      Purpose:          ROLLBACK script for NC_CustomerPaymentHistory_PackageExecutionHistoryID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
AND [name] = N'NC_CustomerPaymentHistory_PackageExecutionHistoryID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPaymentHistory.[NC_CustomerPaymentHistory_PackageExecutionHistoryID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
                                                            AND [name] = N'NC_CustomerPaymentHistory_PackageExecutionHistoryID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerPaymentHistory_PackageExecutionHistoryID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerPaymentHistory_PackageExecutionHistoryID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerPaymentHistory_PackageExecutionHistoryID] does not exist.'
            END
GO