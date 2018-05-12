USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		Rollback Foreign Key [Coupon].[FK_CouponCustomerMap_Coupon_CouponID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CouponCustomerMap_Coupon_CouponID]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[CouponCustomerMap]'))
	BEGIN

		ALTER TABLE [Coupon].[CouponCustomerMap] DROP CONSTRAINT [FK_CouponCustomerMap_Coupon_CouponID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CouponCustomerMap_Coupon_CouponID]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[CouponCustomerMap]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_CouponCustomerMap_Coupon_CouponID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_CouponCustomerMap_Coupon_CouponID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_CouponCustomerMap_Coupon_CouponID] does not exist.'
	END
GO
