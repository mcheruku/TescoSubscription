/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_CustomerID] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_CustomerID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_CustomerID] 
                    ON [tescosubscription].[CustomerSubscription] ([CustomerID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_CustomerID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_CustomerID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_CustomerID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_CustomerID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
