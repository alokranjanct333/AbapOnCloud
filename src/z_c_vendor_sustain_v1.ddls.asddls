@AbapCatalog.sqlViewName: 'ZCVENSUSTAV1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Vendor Sustaiblity Comsposite View'



@Analytics.query: true

//@VDM.viewType: #CONSUMPTION
//@VDM:{viewType: #COMPOSITE}
//@OData.publish: true  not in cloud

@UI.selectionPresentationVariant:[ 
{       // start KPI 1st score by vendor
    qualifier: 'KPIScoreByVendor',                     
    presentationVariantQualifier: 'KPIScoreByVendor',  
    selectionVariantQualifier: 'KPIScoreByVendor'      
},      // end KPI 1st score by vendor
   {  // start 2nd KPI for Sustainblity
   qualifier: 'KPISustainByVendor',
   presentationVariantQualifier: 'KPISustainByVendor',
   selectionVariantQualifier: 'KPISustainByVendor'
   }, // end  2nd  KPI for Sustainblity   
   {  // start 3nd KPI for Sustainblity
   qualifier: 'KPIEnvrByVendor',
   presentationVariantQualifier: 'KPIEnvrByVendor',
   selectionVariantQualifier: 'KPIEnvrByVendor'
   }, // end  3nd  KPI for Sustainblity  
   {  // start 4th KPI for TotalEcoScore
   qualifier: 'KPITScoreByVendor',
   presentationVariantQualifier: 'KPITScoreByVendor',
   selectionVariantQualifier: 'KPITScoreByVendor'
   }, // end  4th  KPI for TotalEcoScore   
{
    qualifier: 'Default',
    presentationVariantQualifier: 'Default',
    selectionVariantQualifier: 'Default'
}]

@UI.presentationVariant:[ 
{ //start added for 1st KPI card
    qualifier: 'KPIScoreByVendor',text: 'KPI: Score Ranking per Vendor',     
    visualizations: [
    {type: #AS_CHART,qualifier: 'ChartRankByVendorScore'},
    {type: #AS_DATAPOINT,qualifier: 'beurt'}]
},  //end added for 1st KPI card
{   //start added for 2st KPI card
    qualifier: 'KPISustainByVendor',text: 'KPI: Sustain Ranking per Vendor',
    visualizations: [
    {type: #AS_CHART,qualifier: 'ChartRankByVendorSustain'}
    ,{type: #AS_DATAPOINT,qualifier: 'Socialresponsibility'}]
},   //end added for 2st KPI card
{   //start added for 3st KPI card
    qualifier: 'KPIEnvrByVendor',text: 'KPI: Environment Ranking per Vendor',
    visualizations: [
     {type: #AS_CHART,    qualifier: 'ChartRankByVendorEnvr'}
    ,{type: #AS_DATAPOINT,qualifier: 'Environment'}]
},   //end added for 3st KPI card
{   //start added for 4th KPI card
    qualifier: 'KPITScoreByVendor',text: 'KPI: Total Score Ranking per Vendor',
    visualizations: [
     {type: #AS_CHART,    qualifier: 'ChartRankByVendorTScore'}
    ,{type: #AS_DATAPOINT,qualifier: 'TotalEcoScore'}]
},   //end added for 4th KPI card
{   //start added for visual filter
    qualifier:'ScoreByVendor',text:'Filter: Score By Vendor',
    visualizations: [
    {type: #AS_CHART,qualifier:'ChartScoreByVendor'}]
},   //end added for visual filter
{    // main area
    qualifier:'Default',
    visualizations: [
    {type: #AS_CHART,qualifier: 'ChartDefault'}]  // main area
}]
 
@UI.selectionVariant: [
{qualifier: 'KPIScoreByVendor',text: 'Default'},     // 1st kpi 
{qualifier: 'KPISustainByVendor',text: 'Default'},  // 2nd kpi 
{qualifier: 'KPIEnvrByVendor',text: 'Default'},      // 3rd kpi 
{qualifier: 'Default',text: 'Default'}]

@UI.chart:[ 
{   // start 1st KPI
    qualifier: 'ChartRankByVendorScore',chartType:#LINE,
    dimensions:  [ 'lifnr' ], 
    measures:  [ 'beurt' ],
    dimensionAttributes: [{dimension: 'lifnr',role: #CATEGORY}],
    measureAttributes: [{measure: 'beurt',role: #AXIS_1}] 
},  // end 1st KPI
{  // start 2nd kpi chart
    qualifier: 'ChartRankByVendorSustain',chartType: #VERTICAL_BULLET,
    dimensions:  [ 'lifnr' ], 
    measures:  [ 'Socialresponsibility'],
    dimensionAttributes: [{dimension: 'lifnr',role: #CATEGORY}],
    measureAttributes: [{measure: 'Socialresponsibility',role: #AXIS_1}] 
},      // end 2nd kpi chart

{  // start 3rd kpi chart
    qualifier: 'ChartRankByVendorEnvr',chartType: #VERTICAL_BULLET,
    dimensions:  [ 'lifnr' ], 
    measures:  [ 'Environment' ],
    dimensionAttributes: [{dimension: 'lifnr',role: #CATEGORY}],
    measureAttributes: [{measure: 'Environment',role: #AXIS_1}] 
},      // end 3rd kpi chart

{  // start 4th kpi chart
    qualifier: 'ChartRankByVendorTScore',chartType: #VERTICAL_BULLET,
    dimensions:  [ 'lifnr' ], 
    measures:  ['Socialresponsibility','Environment', 'TotalEcoScore' ],
    dimensionAttributes: [{dimension: 'lifnr',role: #CATEGORY}],
    measureAttributes: [{measure: 'Socialresponsibility',role: #AXIS_1},
                        {measure: 'TotalEcoScore',role: #AXIS_1},
                        {measure: 'Environment',role: #AXIS_1}] 
},      // end 4th kpi chart

{    //start added for visual filter   
    qualifier:'ChartScoreByVendor',chartType: #DONUT,
    dimensions:  [ 'ekorg' ], 
    measures:  [ 'beurt' ],
    dimensionAttributes: [{dimension: 'ekorg',role: #CATEGORY}],
    measureAttributes: [{measure: 'beurt',role: #AXIS_1}]  //End added for visual filter
},
{   // main area
    qualifier: 'ChartDefault',
    chartType: #VERTICAL_BULLET,
    dimensions: ['lifnr'],
    measures: ['Price','Quality','Delivery','Service','Sustainability']} //// main area
]

define view Z_C_VENDOR_SUSTAIN_V1 as select from Z_I_Vendor_Sustain
//association to [0..1] zsustain 

 {
    //Z_I_Vendor_Sustain
    @UI.selectionField: [{position: 10 }]
//    @UI.selectionField.position: 10
   key ekorg,
//    @UI.selectionField.position: 20
    @UI.selectionField: [{position: 20 }]
    lifnr,
    @UI.dataPoint.title: 'Supplier Rank by Score'
    beurt,
    Price,
    Quality,
    Delivery,
    Service,     
    Sustainability,
    @UI.dataPoint.title: 'Supplier Rank by Socialresponsibility'
    Socialresponsibility,
    @UI.dataPoint.title: 'Supplier Rank by Environment'
    Environment,
    @UI.dataPoint.title: 'Score By Sustainablity'
    TotalEcoScore
}
