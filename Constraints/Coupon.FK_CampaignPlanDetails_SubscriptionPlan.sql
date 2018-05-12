USE Tescosubscription

GO

/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [TescoSubscription].[SubscriptionPlan] and [Coupon].[CampaignPlanDetails]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[TescoSubscription].[SubscriptionPlan]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignPlanDetails_SubscriptionPlan')
			BEGIN
ALTER TABLE [Coupon].[CampaignPlanDetails]  WITH CHECK ADD  CONSTRAINT [FK_CampaignPlanDetails_SubscriptionPlan] FOREIGN KEY([SubscriptionPlanID])
REFERENCES [TescoSubscription].[SubscriptionPlan] ([SubscriptionPlanID])

ALTER TABLE [Coupon].[CampaignPlanDetails] CHECK CONSTRAINT [FK_CampaignPlanDetails_SubscriptionPlan]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignPlanDetails_SubscriptionPlan')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CampaignPlanDetails_SubscriptionPlan] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CampaignPlanDetails_SubscriptionPlan] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CampaignPlanDetails_SubscriptionPlan] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[DiscountTypeMaster]/[Coupon].[CampaignPlanDetails] does not exist.',16,1)
	END
GO

GO