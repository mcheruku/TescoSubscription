/*

Author:     Robin 
Created:    7 Jan 2013
Purpose:    Create index   [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] on [tescosubscription].[CustomerSubscriptionSwitchHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]', N'U')
                   AND   [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID') 
          BEGIN
                    CREATE CLUSTERED INDEX [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] 
                    ON [tescosubscription].[CustomerSubscriptionSwitchHistory] (CustomerSubscriptionID)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U')
                                 AND   [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16, 1)
        END

GO
