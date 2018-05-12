/*

	Author:			Robin
	Date created:	30-jul-2013
	Purpose:		Rollback Procedure [Coupon].[CouponDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet1]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet1] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponDetailsGet1] does not exist.'
	END
GO
