USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Foreign Key [Coupon].[FK_CampaignPlanDetails_SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CampaignPlanDetails_SubscriptionPlan]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[CampaignPlanDetails]'))
	BEGIN

		ALTER TABLE [Coupon].[CampaignPlanDetails] DROP CONSTRAINT [FK_CampaignPlanDetails_SubscriptionPlan]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CampaignPlanDetails_SubscriptionPlan]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[CampaignPlanDetails]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_CampaignPlanDetails_SubscriptionPlan] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_CampaignPlanDetails_SubscriptionPlan] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_CampaignPlanDetails_SubscriptionPlan] does not exist.'
	END
GO
