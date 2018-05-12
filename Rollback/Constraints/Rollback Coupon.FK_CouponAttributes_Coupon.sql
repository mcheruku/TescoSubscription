/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Foreign Key [Coupon].[FK_CouponAttributes_Coupon]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CouponAttributes_Coupon]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[CouponAttributes]'))
	BEGIN

		ALTER TABLE [Coupon].[CouponAttributes] DROP CONSTRAINT [FK_CouponAttributes_Coupon]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CouponAttributes_Coupon]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[CouponAttributes]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_CouponAttributes_Coupon] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_CouponAttributes_Coupon] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_CouponAttributes_Coupon] does not exist.'
	END
GO
