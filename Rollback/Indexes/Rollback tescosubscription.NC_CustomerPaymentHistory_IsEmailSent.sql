/*
      Created By:       Saritha Kommineni
      Date created:     04 Oct 2011
      Purpose:          ROLLBACK script for NC_CustomerPaymentHistory_IsEmailSent
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
AND [name] = N'NC_CustomerPaymentHistory_IsEmailSent')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPaymentHistory.[NC_CustomerPaymentHistory_IsEmailSent]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPaymentHistory', N'U') 
                                                            AND [name] = N'NC_CustomerPaymentHistory_IsEmailSent')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerPaymentHistory_IsEmailSent] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerPaymentHistory_IsEmailSent] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerPaymentHistory_IsEmailSent] does not exist.'
            END
GO