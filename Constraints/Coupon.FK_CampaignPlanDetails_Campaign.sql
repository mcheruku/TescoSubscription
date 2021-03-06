USE Tescosubscription

GO

/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignPlanDetails]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignPlanDetails_Campaign')
			BEGIN
ALTER TABLE [Coupon].[CampaignPlanDetails]  WITH CHECK ADD  CONSTRAINT [FK_CampaignPlanDetails_Campaign] FOREIGN KEY([CampaignID])
REFERENCES [Coupon].[Campaign] ([CampaignID])

ALTER TABLE [Coupon].[CampaignPlanDetails] CHECK CONSTRAINT [FK_CampaignPlanDetails_Campaign]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignPlanDetails_Campaign')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CampaignPlanDetails_Campaign] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CampaignPlanDetails_Campaign] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CampaignPlanDetails_Campaign] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[DiscountTypeMaster]/[Coupon].[CampaignPlanDetails] does not exist.',16,1)
	END
GO

GO