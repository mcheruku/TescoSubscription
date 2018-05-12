USE Tescosubscription

GO

/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignDiscountType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_Campaign')
			BEGIN
ALTER TABLE [Coupon].[CampaignDiscountType]  WITH CHECK ADD  CONSTRAINT [FK_CampaignDiscountType_Campaign] FOREIGN KEY([CampaignID])
REFERENCES [Coupon].[Campaign] ([CampaignID])

ALTER TABLE [Coupon].[CampaignDiscountType] CHECK CONSTRAINT [FK_CampaignDiscountType_Campaign]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_Campaign')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CampaignDiscountType_Campaign] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CampaignDiscountType_Campaign] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CampaignDiscountType_Campaign] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[DiscountTypeMaster]/[Coupon].[CampaignDiscountType] does not exist.',16,1)
	END
GO

GO/*

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

GOUSE Tescosubscription

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

GOUSE Tescosubscription

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

GOUSE TescoSubscription
GO
/*

	Author:			Infosys Pvt Ltd
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignTypeMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
			BEGIN

			ALTER TABLE [Coupon].[Campaign]  WITH NOCHECK ADD  CONSTRAINT [FK_Campaign_CampaignTypeMaster_CampaignTypeID] FOREIGN KEY([CampaignTypeID])
			REFERENCES [Coupon].[CampaignTypeMaster] ([CampaignTypeID])
			NOT FOR REPLICATION 
		

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Campaign]/[Coupon].[CampaignTypeMaster] does not exist.',16,1)
	END
GO
USE TescoSubscription

GO
/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CouponUsageType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
			BEGIN
ALTER TABLE [Coupon].[Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Campaign_UsageTypeID] FOREIGN KEY([UsageTypeID])
REFERENCES [Coupon].[CouponUsageType] ([UsageTypeID])

ALTER TABLE [Coupon].[Campaign] CHECK CONSTRAINT [FK_Campaign_UsageTypeID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_UsageTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_UsageTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_UsageTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[CouponUsageType]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO

GO/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponAttributes]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponAttributes_Coupon')
			BEGIN

				ALTER TABLE [Coupon].[CouponAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CouponAttributes_Coupon] FOREIGN KEY([CouponID])
				REFERENCES [Coupon].[Coupon] ([CouponID])

				ALTER TABLE [Coupon].[CouponAttributes] CHECK CONSTRAINT [FK_CouponAttributes_Coupon]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponAttributes_Coupon')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponAttributes_Coupon] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponAttributes_Coupon] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponAttributes_Coupon] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponAttributes] does not exist.',16,1)
	END
GO
USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponCustomerMap]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponCustomerMap]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponCustomerMap_Coupon_CouponID')
			BEGIN

				ALTER TABLE [Coupon].[CouponCustomerMap]  WITH CHECK ADD  CONSTRAINT [FK_CouponCustomerMap_Coupon_CouponID] FOREIGN KEY([CouponID])
				REFERENCES [Coupon].[Coupon] ([CouponID])

				ALTER TABLE [Coupon].[CouponCustomerMap] CHECK CONSTRAINT [FK_CouponCustomerMap_Coupon_CouponID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponCustomerMap_Coupon_CouponID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponCustomerMap] does not exist.',16,1)
	END
GO
/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponRedemption]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponRedemption_Coupon')
			BEGIN

				ALTER TABLE [Coupon].[CouponRedemption]  WITH CHECK ADD  CONSTRAINT [FK_CouponRedemption_Coupon] FOREIGN KEY([CouponCode])
				REFERENCES [Coupon].[Coupon] ([CouponCode])

				ALTER TABLE [Coupon].[CouponRedemption] CHECK CONSTRAINT [FK_CouponRedemption_Coupon]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponRedemption_Coupon')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponRedemption_Coupon] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponRedemption_Coupon] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponRedemption_Coupon] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponRedemption] does not exist.',16,1)
	END
GO
USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[Campaign]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
			BEGIN

				ALTER TABLE [Coupon].[Coupon] WITH NOCHECK ADD  CONSTRAINT [FK_Coupon_Campaign_CampaignID] FOREIGN KEY([CampaignId])
				REFERENCES [Coupon].[Campaign] ([CampaignID])

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Coupon_Campaign_CampaignID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Coupon_Campaign_CampaignID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Coupon_Campaign_CampaignID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO
USE Tescosubscription

GO

/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignDiscountType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_Campaign')
			BEGIN
ALTER TABLE [Coupon].[CampaignDiscountType]  WITH CHECK ADD  CONSTRAINT [FK_CampaignDiscountType_Campaign] FOREIGN KEY([CampaignID])
REFERENCES [Coupon].[Campaign] ([CampaignID])

ALTER TABLE [Coupon].[CampaignDiscountType] CHECK CONSTRAINT [FK_CampaignDiscountType_Campaign]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CampaignDiscountType_Campaign')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CampaignDiscountType_Campaign] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CampaignDiscountType_Campaign] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CampaignDiscountType_Campaign] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[DiscountTypeMaster]/[Coupon].[CampaignDiscountType] does not exist.',16,1)
	END
GO

GO/*

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

GOUSE Tescosubscription

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

GOUSE Tescosubscription

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

GOUSE TescoSubscription
GO
/*

	Author:			Infosys Pvt Ltd
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignTypeMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
			BEGIN

			ALTER TABLE [Coupon].[Campaign]  WITH NOCHECK ADD  CONSTRAINT [FK_Campaign_CampaignTypeMaster_CampaignTypeID] FOREIGN KEY([CampaignTypeID])
			REFERENCES [Coupon].[CampaignTypeMaster] ([CampaignTypeID])
			NOT FOR REPLICATION 
		

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Campaign]/[Coupon].[CampaignTypeMaster] does not exist.',16,1)
	END
GO
USE TescoSubscription

GO
/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CouponUsageType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
			BEGIN
ALTER TABLE [Coupon].[Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Campaign_UsageTypeID] FOREIGN KEY([UsageTypeID])
REFERENCES [Coupon].[CouponUsageType] ([UsageTypeID])

ALTER TABLE [Coupon].[Campaign] CHECK CONSTRAINT [FK_Campaign_UsageTypeID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_UsageTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_UsageTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_UsageTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[CouponUsageType]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO

GO/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponAttributes]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponAttributes_Coupon')
			BEGIN

				ALTER TABLE [Coupon].[CouponAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CouponAttributes_Coupon] FOREIGN KEY([CouponID])
				REFERENCES [Coupon].[Coupon] ([CouponID])

				ALTER TABLE [Coupon].[CouponAttributes] CHECK CONSTRAINT [FK_CouponAttributes_Coupon]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponAttributes_Coupon')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponAttributes_Coupon] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponAttributes_Coupon] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponAttributes_Coupon] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponAttributes] does not exist.',16,1)
	END
GO
USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponCustomerMap]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponCustomerMap]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponCustomerMap_Coupon_CouponID')
			BEGIN

				ALTER TABLE [Coupon].[CouponCustomerMap]  WITH CHECK ADD  CONSTRAINT [FK_CouponCustomerMap_Coupon_CouponID] FOREIGN KEY([CouponID])
				REFERENCES [Coupon].[Coupon] ([CouponID])

				ALTER TABLE [Coupon].[CouponCustomerMap] CHECK CONSTRAINT [FK_CouponCustomerMap_Coupon_CouponID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponCustomerMap_Coupon_CouponID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponCustomerMap_Coupon_CouponID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponCustomerMap] does not exist.',16,1)
	END
GO
/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[CouponRedemption]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponRedemption_Coupon')
			BEGIN

				ALTER TABLE [Coupon].[CouponRedemption]  WITH CHECK ADD  CONSTRAINT [FK_CouponRedemption_Coupon] FOREIGN KEY([CouponCode])
				REFERENCES [Coupon].[Coupon] ([CouponCode])

				ALTER TABLE [Coupon].[CouponRedemption] CHECK CONSTRAINT [FK_CouponRedemption_Coupon]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CouponRedemption_Coupon')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CouponRedemption_Coupon] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CouponRedemption_Coupon] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CouponRedemption_Coupon] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[CouponRedemption] does not exist.',16,1)
	END
GO
USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[Campaign]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
			BEGIN

				ALTER TABLE [Coupon].[Coupon] WITH NOCHECK ADD  CONSTRAINT [FK_Coupon_Campaign_CampaignID] FOREIGN KEY([CampaignId])
				REFERENCES [Coupon].[Campaign] ([CampaignID])

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Coupon_Campaign_CampaignID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Coupon_Campaign_CampaignID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Coupon_Campaign_CampaignID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO
USE Tescosubscription

GO

/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignDiscountType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Descr/*

	Author:			Saritha K
	Date created:	06-JAN-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerPaymentHistory] and [tescosubscription].[CustomerPaymentHistoryResponse]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] FOREIGN KEY([CustomerPaymentHistoryID])
				REFERENCES [tescosubscription].[CustomerPaymentHistory] ([CustomerPaymentHistoryID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse] CHECK CONSTRAINT [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerPaymentHistory]/[tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha k
	Date created:	06-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerPaymentHistoryResponse]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] FOREIGN KEY([PaymentStatusID])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse] CHECK CONSTRAINT [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16,1)
	END
GO
/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[ChannelMaster] and [tescosubscription].[CustomerPaymentHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_ChannelMaster_ChannelID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] FOREIGN KEY([ChannelID])
				REFERENCES [tescosubscription].[ChannelMaster] ([ChannelID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory] CHECK CONSTRAINT [FK_CustomerPaymentHistory_ChannelMaster_ChannelID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_ChannelMaster_ChannelID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[ChannelMaster]/[tescosubscription].[CustomerPaymentHistory] does not exist.',16,1)
	END
GO
/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerPayment] and [tescosubscription].[CustomerPaymentHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID] FOREIGN KEY([CustomerPaymentID])
				REFERENCES [tescosubscription].[CustomerPayment] ([CustomerPaymentID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory] CHECK CONSTRAINT [FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistory_CustomerPayment_CustomerPaymentID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerPayment]/[tescosubscription].[CustomerPaymentHistory] does not exist.',16,1)
	END
GO
/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerPaymentHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
				REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory] CHECK CONSTRAINT [FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistory_CustomerSubscription_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerPaymentHistory] does not exist.',16,1)
	END
GO
USE TescoSubscription

GO
/*

	Author:			Robin John
	Date created:	20-April-2014
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerPaymentRemainingDetail] and [TescoSubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[TescoSubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerPaymentRemainingDetail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
REFERENCES [TescoSubscription].[CustomerSubscription] ([CustomerSubscriptionID])

ALTER TABLE [tescosubscription].[CustomerPaymentRemainingDetail] CHECK CONSTRAINT [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [TescoSubscription].[CustomerSubscription]/[tescosubscription].[CustomerPaymentRemainingDetail] does not exist.',16,1)
	END
GO

GO


 /*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PaymentModeMaster] and [tescosubscription].[CustomerPayment]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPayment_PaymentModeMaster_PaymentModeID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPayment]  WITH NOCHECK ADD  CONSTRAINT [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] FOREIGN KEY([PaymentModeID])
				REFERENCES [tescosubscription].[PaymentModeMaster] ([PaymentModeID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[CustomerPayment] CHECK CONSTRAINT [FK_CustomerPayment_PaymentModeMaster_PaymentModeID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPayment_PaymentModeMaster_PaymentModeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PaymentModeMaster]/[tescosubscription].[CustomerPayment] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha Kommineni
	Date created:	14-10-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerSubscriptionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
 
				IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
					OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
					BEGIN
						IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID')
							BEGIN

								ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
								REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

								ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID]

							
	IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerSubscriptionHistory] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha Kommineni
	Date created:	22-Aug-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscriptionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] FOREIGN KEY([SubscriptionStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusID])

				ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscriptionHistory] does not exist.',16,1)
	END
GO
/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16,1)
	END
GO

GO/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchStatus')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] FOREIGN KEY(SwitchStatus)
REFERENCES [tescosubscription].[StatusMaster] (StatusId)

ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16,1)
	END
GO

GO/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionPlan] and [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchTo')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchTo] FOREIGN KEY(SwitchTo)
REFERENCES [tescosubscription].[SubscriptionPlan] (SubscriptionPlanID)

ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchTo]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchTo')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionPlan]/[tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16,1)
	END
GO

GO/*

	Author:			Saritha Kommineni
	Date created:	24-Aug-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_PaymentProcessStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] FOREIGN KEY([PaymentProcessStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_PaymentProcessStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO
/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_SubscriptionStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] FOREIGN KEY([SubscriptionStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_StatusMaster_SubscriptionStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_SubscriptionStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO
/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionPlan] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH NOCHECK ADD  CONSTRAINT [FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID] FOREIGN KEY([SubscriptionPlanID])
				REFERENCES [tescosubscription].[SubscriptionPlan] ([SubscriptionPlanID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_SubscriptionPlan_SubscriptionPlanID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionPlan]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO
/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
		
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchCustomerSubscriptionID')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_SwitchCustomerSubscriptionID] FOREIGN KEY([SwitchCustomerSubscriptionID])
REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_SwitchCustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchCustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_SwitchCustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO

GO/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	15 Jan 2013		Robin		<TFS no.>		    Created the constraint 

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchTo')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_SwitchTo] FOREIGN KEY(SwitchTo)
REFERENCES [tescosubscription].[SubscriptionPlan] (SubscriptionPlanID)

ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_SwitchTo]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchTo')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_SwitchTo] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_SwitchTo] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_SwitchTo] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO

GO/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PackageExecutionHistory] and [tescosubscription].[PackageErrorLog]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[PackageErrorLog]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID')
			BEGIN

		ALTER TABLE [tescosubscription].[PackageErrorLog] WITH CHECK ADD  CONSTRAINT [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] FOREIGN KEY([PackageExecutionHistoryID])
          REFERENCES [tescosubscription].[PackageExecutionHistory] ([PackageExecutionHistoryID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[PackageErrorLog] CHECK CONSTRAINT [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PackageExecutionHistory]/[tescosubscription].[PackageErrorLog] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PackageMaster] and [tescosubscription].[PackageExecutionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageExecutionHistory_PackageMaster_PackageID')
			BEGIN

		ALTER TABLE [tescosubscription].[PackageExecutionHistory] WITH CHECK ADD  CONSTRAINT [FK_PackageExecutionHistory_PackageMaster_PackageID] FOREIGN KEY([PackageID])
          REFERENCES [tescosubscription].[PackageMaster] ([PackageID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[PackageExecutionHistory] CHECK CONSTRAINT [FK_PackageExecutionHistory_PackageMaster_PackageID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageExecutionHistory_PackageMaster_PackageID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PackageMaster]/[tescosubscription].[PackageExecutionHistory] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PackageExecutionHistory] and [tescosubscription].[PackageTransactionLog]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[PackageTransactionLog]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID')
			BEGIN

		ALTER TABLE [tescosubscription].[PackageTransactionLog] WITH CHECK ADD  CONSTRAINT [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] FOREIGN KEY([PackageExecutionHistoryID])
          REFERENCES [tescosubscription].[PackageExecutionHistory] ([PackageExecutionHistoryID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[PackageTransactionLog] CHECK CONSTRAINT [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PackageExecutionHistory]/[tescosubscription].[PackageTransactionLog] does not exist.',16,1)
	END
GO
/*

	Author:			Robin
	Date created:	19-Dec-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionPlanSlot] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlanSlot_SubscriptionPlan')
			BEGIN

				
	ALTER TABLE [tescosubscription].[SubscriptionPlanSlot]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionPlanSlot_SubscriptionPlan] FOREIGN KEY([SubscriptionPlanID])
	REFERENCES [tescosubscription].[SubscriptionPlan] ([SubscriptionPlanID])

				ALTER TABLE [tescosubscription].[SubscriptionPlanSlot] CHECK CONSTRAINT [FK_SubscriptionPlanSlot_SubscriptionPlan]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlanSlot_SubscriptionPlan')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionPlanSlot]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[BusinessMaster] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[BusinessMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_BusinessMaster_BusinessID')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_BusinessMaster_BusinessID] FOREIGN KEY([BusinessID])
				REFERENCES [tescosubscription].[BusinessMaster] ([BusinessID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_BusinessMaster_BusinessID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_BusinessMaster_BusinessID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_BusinessMaster_BusinessID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_BusinessMaster_BusinessID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_BusinessMaster_BusinessID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[BusinessMaster]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CountryCurrencyMap] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyMap]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID] FOREIGN KEY([CountryCurrencyID])
				REFERENCES [tescosubscription].[CountryCurrencyMap] ([CountryCurrencyID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_CountryCurrencyMap_CountryCurrencyID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CountryCurrencyMap]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
/*

	Author:			Robin John
	Date created:	19-Dec-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PaymentInstallment] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_PaymentInstallment')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_PaymentInstallment] FOREIGN KEY([PaymentInstallmentID])
				REFERENCES [tescosubscription].[PaymentInstallment] ([PaymentInstallmentID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_PaymentInstallment]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_PaymentInstallment')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_PaymentInstallment] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PaymentInstallment]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionMaster] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] FOREIGN KEY([SubscriptionID])
				REFERENCES [tescosubscription].[SubscriptionMaster] ([SubscriptionID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionMaster]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
