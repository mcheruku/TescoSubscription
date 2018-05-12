/*

Author:     Saritha Kommineni
Created:    20 Sep 2011
Purpose:    Create index   [NC_CustomerPayment_CustomerID] on [tescosubscription].[CustomerPayment]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]', N'U')
                   AND   [name] = N'NC_CustomerPayment_CustomerID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPayment_CustomerID] 
                    ON [tescosubscription].[CustomerPayment] ([CustomerID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U')
                                 AND   [name] = N'NC_CustomerPayment_CustomerID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPayment_CustomerID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPayment_CustomerID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPayment_CustomerID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPayment] does not exist.',16, 1)
        END

GO
