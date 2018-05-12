/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]'))
	BEGIN

		ALTER TABLE [tescosubscription].[SubscriptionPlan] DROP CONSTRAINT [FK_SubscriptionPlan_BusinessMaster_BusinessID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_SubscriptionPlan_BusinessMaster_BusinessID] does not exist.'
	END
GO
