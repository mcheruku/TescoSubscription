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
