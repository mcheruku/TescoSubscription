/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[DiscountTypeMaster] and [Coupon].[CampaignDiscountType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[DiscountTypeMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_DiscountTypeMaster')
			BEGIN
ALTER TABLE [Coupon].[CampaignDiscountType]  WITH CHECK ADD  CONSTRAINT [FK_CampaignDiscountType_DiscountTypeMaster] FOREIGN KEY([DiscountTypeID])
REFERENCES [Coupon].[DiscountTypeMaster] ([DiscountTypeID])

ALTER TABLE [Coupon].[CampaignDiscountType] CHECK CONSTRAINT [FK_CampaignDiscountType_DiscountTypeMaster]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_DiscountTypeMaster')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CampaignDiscountType_DiscountTypeMaster] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CampaignDiscountType_DiscountTypeMaster] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CampaignDiscountType_DiscountTypeMaster] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[DiscountTypeMaster]/[Coupon].[CampaignDiscountType] does not exist.',16,1)
	END
GO

GO