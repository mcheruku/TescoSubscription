USE TESCOSUBSCRIPTION
GO
	
IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] not dropped.',16,1)
			END
	END
GO
	
CREATE PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]
	@CustomerDateXML XML
AS
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet]  
** AUTHOR         : Navdeep B. Singh 
** DESCRIPTION    : Brings Active subscriptions for Customer(s) in CSV format.
** DATE WRITTEN   : 12th May 2014                  
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
** USAGE		  :	OFTEN
** CALLED BY	  :	JUVO
*******************************************************************************************  
*******************************************************************************************/
/*SAMPLE INPUT XML:-	
	
	<CustomerDateCollection>
	  <CustomerDateRecord>
		<CustomerID>3188294</CustomerID>
		<UpdateDate>2014-02-22 09:40:50.590</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>2300273634</CustomerID>
		<UpdateDate>2014-05-03 23:30:08.422</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>16250916</CustomerID>
		<UpdateDate>2014-02-22 09:40:50.581</UpdateDate>
	  </CustomerDateRecord>
	  <CustomerDateRecord>
		<CustomerID>2300273631</CustomerID>
		<UpdateDate>2014-05-18 23:30:25.210</UpdateDate>
	  </CustomerDateRecord>
	</CustomerDateCollection>
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description	
	22 June 14		Parshant Garg					1. Added UpdateDate to the output			
													2. Allowed all the input values to be returned even if customer subscription not found 
*/

BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @XmlDocumentHandle		INT
	
	-- CREATE AN INTERNAL REPRESENTATION OF THE XML DOCUMENT.	
	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @CustomerDateXML
	
	--INSERT INTO #TempXMLData
	SELECT TempCustDateData.*						
	INTO #TempXMLData
	FROM(
		SELECT *
		FROM OPENXML (@XmlDocumentHandle, 'CustomerDateCollection/CustomerDateRecord',2)
		WITH (CustomerID	BIGINT,
			  UpdateDate	DATETIME
			  )
		)TempCustDateData
	
	EXEC sp_xml_removedocument @XmlDocumentHandle	
	
	;WITH CTE
	AS
	(
	SELECT  ROW_NUMBER() OVER (PARTITION BY CS.CustomerID ORDER BY CS.UTCUpdatedDateTime DESC ) AS RowNum 
			,TmpAlias.CustomerID
			,SP.PlanName AS CSVActivePlans
			,CS.UTCUpdatedDateTime
			,TmpAlias.UpdateDate,CS.Customerplanstartdate,CS.Customerplanenddate
	FROM  #TempXMLData TmpAlias (NOLOCK) -- updated order by Parshant on 22 June 14
	LEFT OUTER JOIN [TescoSubscription].[CustomerSubscription] CS(NOLOCK)  -- updated order by Parshant on 22 June 14
		ON TmpAlias.CustomerID = CS.CustomerID
		AND CS.Customerplanstartdate <= TmpAlias.UpdateDate
		And CS.Customerplanenddate >= TmpAlias.UpdateDate 
		LEFT OUTER JOIN [Tescosubscription].[SubscriptionPlan] SP (NOLOCK)
		ON CS.SubscriptionPlanID = SP.SubscriptionPlanID	
  
	)
	SELECT distinct C.CustomerID
			,C.CSVActivePlans
			,C.UpdateDate -- added by Parshant on 22 June 14
	FROM CTE C

	DROP TABLE #TempXMLData	
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerActiveSubscriptionsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] not created.',16,1)
	END
GO
