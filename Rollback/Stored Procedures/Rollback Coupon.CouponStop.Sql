/*

	Author:			Swaraj
	Date created:	16-Oct-2012
	Purpose:		Rollback Procedure [Coupon].[CouponStop]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponStop]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponStop]

		IF OBJECT_ID(N'[Coupon].[CouponStop]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponStop] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponStop] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponStop] does not exist.'
	END
GO
