USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [Coupon].[CouponDetailsGet4]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[CouponDetailsGet4]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet4] 

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet4]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet4]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet4]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponDetailsGet4]  does not exist.'
	END
GO