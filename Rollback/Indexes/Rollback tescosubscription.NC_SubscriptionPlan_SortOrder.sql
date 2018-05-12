/*
      Created By:       Saritha Kommineni
      Date created:     20 Sep 2011
      Purpose:          ROLLBACK script for tescosubscription.NC_SubscriptionPlan_SortOrder
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      25 Aug 2011	 Saritha							removed SubscriptionStatus in index	
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.SubscriptionPlan', N'U') 
AND [name] = N'tescosubscription.NC_SubscriptionPlan_SortOrder')
            BEGIN
                        DROP INDEX tescosubscription.SubscriptionPlan.[tescosubscription.NC_SubscriptionPlan_SortOrder]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.SubscriptionPlan', N'U') 
                                                            AND [name] = N'tescosubscription.NC_SubscriptionPlan_SortOrder')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[tescosubscription.NC_SubscriptionPlan_SortOrder] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[tescosubscription.NC_SubscriptionPlan_SortOrder] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[tescosubscription.NC_SubscriptionPlan_SortOrder] does not exist.'
            END
GO