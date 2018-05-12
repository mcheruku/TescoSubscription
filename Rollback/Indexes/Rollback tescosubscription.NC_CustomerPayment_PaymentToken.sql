/*
      Created By:       Robin
      Date created:     26 May 2014
      Purpose:          ROLLBACK script for NC_CustomerPayment_PaymentToken
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
    
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPayment', N'U') 
AND [name] = N'NC_CustomerPayment_PaymentToken')
            BEGIN
                        DROP INDEX tescosubscription.CustomerPayment.[NC_CustomerPayment_PaymentToken]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerPayment', N'U') 
                                                            AND [name] = N'NC_CustomerPayment_PaymentToken')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerPayment_PaymentToken] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerPayment_PaymentToken] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerPayment_PaymentToken] does not exist.'
            END
GO