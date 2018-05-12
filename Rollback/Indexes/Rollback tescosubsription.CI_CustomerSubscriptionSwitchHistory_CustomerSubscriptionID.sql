/*
      Created By:       Robin 
      Date created:     17 Jan 2013
      Purpose:          ROLLBACK script for CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
     
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchHistory', N'U') 
AND [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscriptionSwitchHistory.[CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscriptionSwitchHistory', N'U') 
                                                            AND [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [Coupon].[CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [Coupon].[CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [Coupon].[CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] does not exist.'
            END
GO