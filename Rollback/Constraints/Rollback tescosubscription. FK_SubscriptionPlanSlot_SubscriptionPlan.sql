/*

	Author:			Robin
	Date created:	19-Dec-2012
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]'))
	BEGIN

		ALTER TABLE [tescosubscription].[SubscriptionPlanSlot] DROP CONSTRAINT [FK_SubscriptionPlanSlot_SubscriptionPlan]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_SubscriptionPlanSlot_SubscriptionPlan] does not exist.'
	END
GO