/*

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
