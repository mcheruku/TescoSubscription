/*

Author:     Saritha Kommineni
Created:    20 Sep 2011
Purpose:    Create index   [NC_SubscriptionPlan_SortOrder] on [tescosubscription].[SubscriptionPlan]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]', N'U')
                   AND   [name] = N'NC_SubscriptionPlan_SortOrder') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_SubscriptionPlan_SortOrder] 
                    ON [tescosubscription].[SubscriptionPlan] ([SortOrder] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U')
                                 AND   [name] = N'NC_SubscriptionPlan_SortOrder') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_SubscriptionPlan_SortOrder] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_SubscriptionPlan_SortOrder] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_SubscriptionPlan_SortOrder] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[SubscriptionPlan] does not exist.',16, 1)
        END

GO
