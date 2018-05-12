/*
      Created By:       Saritha Kommineni
      Date created:     06 Jan 2012
      Purpose:          ROLLBACK script for NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistoryResponse', N'U') 
AND [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPaymentHistoryResponse.[NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistoryResponse', N'U') 
                                                            AND [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] does not exist.'
            END
GO