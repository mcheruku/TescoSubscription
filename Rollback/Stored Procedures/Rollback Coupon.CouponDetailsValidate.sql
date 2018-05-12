USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [Coupon].[CouponDetailsValidate]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[CouponDetailsValidate]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsValidate] 

		IF OBJECT_ID(N'[Coupon].[CouponDetailsValidate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsValidate]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsValidate]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponDetailsValidate]  does not exist.'
	END
GO