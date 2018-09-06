<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="serror" uri="/WEB-INF/ErrorDescripter.tld"%>

<html lang="en" ng-app="esamapp">

<jsp:include page="fragments/headTag.jsp" />

<body>

	<div id="wrapper">
		<jsp:include page="fragments/bodyHeader.jsp" />
		<div id="containerId" class="content"
			ng-controller="SdgDashboardController" ng-cloak>
			<div class="container-fluid">
				<div style="margin-top: 10px;">
					<serror:Error id="msgBox" errorList="${formError}"
						cssInfClass="${className}">
					</serror:Error>
				</div>
			</div>
		
			<div class="container-fluid">

				<div class="sectors" data-html2canvas-ignore="true">
					<nav class="sector" role="navigation">
						<div class="thumb">
							<button class="navbar-toggle" data-toggsamikshaMaple="collapse"
								data-target="#navsector">
								<span class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<div class="sector_wrap">
								<ul class="sectorlists">
									<li ng-repeat="sector in sectors" class="sectorlist"><a
										ng-class="{active:selectedSector.value == sector.value}"
										ng-click="selectSector(sector)" href="#"> {{sector.value}}</a></li>
								</ul>

							</div>
						</div>
					</nav>
					<div class="thumb_slide_ctrl">
						<a href="javascript:void(0)" class="left-arrow"><i
							class="fa fa-6 fa-caret-left" style="font-size: 2em"></i></a> <a
							href="javascript:void(0)" class="right-arrow"><i
							class="fa fa-6 fa-caret-right" style="font-size: 2em"></i></a>
					</div>
				</div>
				<h3 style="line-height: 15px;">Dashboard</h3>
				<div id="nodata"
					ng-class="{'show': utdata.dataCollection.length == 0}"
					class="text-center nodata">
					<h3>
						<i class="fa fa-info-circle"></i>Info
					</h3>
					<h5 class="text-left">
						No data available for the selected indicator and time period.<br>Please
						modify your selection.
					</h5>
					<button type="button" class="btn btn-sm btn-primary" id="closepop">OK</button>
				</div>
<!-- 				No data available pop up box for selected time period -->
				<div id="nodataForSelectedTime"
					ng-class="{'show': utdata.dataCollection.length != 0 && utdata.topPerformers.length == 0}"
					class="text-center nodata">
					<h3>
						<i class="fa fa-info-circle"></i>Info
					</h3>
					<h5 class="text-left">
						No data available for the selected indicator for {{selectedTimeperiod.value}}.<br>Please
						select another time period.
					</h5>
					<button type="button" class="btn btn-sm btn-primary" id="closepop1">OK</button>
				</div>
				<br><br>
				<div id="leftfilter" class="left-div">

					<section class="mar-bot-15" data-html2canvas-ignore="true">
						<!-- left indicator section   -->
						<div class="btn-toolbar" role="toolbar">
							<div class="input-group samikshya-filter">

								<input type="text" placeholder="Select indicator" readonly="" 
									class="form-control" ng-model="selectedIndicator.value"></input>
								<div class="input-group-btn" style="position: relative;">
									<button data-toggle="dropdown" id="ind-list"
										class="btn btn-primary dropdown-toggle" type="button" ng-click="clearList()">
										<i class="fa fa-list"></i>
									</button>

									<ul class="dropdown-menu" role="menu"
										aria-labelledby="ind-list" id="ind_drop">
										<div>
											<form class="navbar-form navbar-left" role="search">
												<input class="form-control" ng-model="query" type="text"
													placeholder="search" autofocus
													onclick="event.cancelBubble=true;" id="searchText">
												<button class="btn btn-primary">
													<i class="fa fa-lg fa-search "></i>
												</button>
											</form>
										</div>
										<li
											ng-repeat="indicator in indicators | filter:query | orderBy:'name'"
											title="{{indicator.value}}"><a
											ng-click="selectIndicator(indicator)" href="#">
												{{indicator.value}}</a></li>
									</ul>
								</div>
								<!-- /btn-group -->
							</div>
						</div>
					</section>
					<!-- left indicator section   -->
					<section class="mar-bot-15" data-html2canvas-ignore="true">
						<div class="btn-toolbar" role="toolbar">
							<div class="input-group samikshya-filter">

								<input type="text" placeholder="Select Source" readonly=""
									class="form-control" ng-model="selectedSource.value"></input>
								<div class="input-group-btn">
									<button data-toggle="dropdown" id="src-list"
										class="btn btn-primary dropdown-toggle pull-left"
										type="button">
										<i class="fa fa-book fa-lg "></i>

									</button>
									<ul class="dropdown-menu" role="menu"
										aria-labelledby="src-list" id="tp_drop">
										<li ng-repeat="source in sources"><a
											ng-click="selectSource(source)" href="#">
												{{source.value}}</a></li>
									</ul>
								</div>
								<!-- /btn-group -->
							</div>
						</div>
					</section>
					<section class="mar-bot-15" data-html2canvas-ignore="true">
						<div class="btn-toolbar" role="toolbar">
							<div class="input-group samikshya-filter">

								<input type="text" placeholder="" class="form-control" readonly=""
									ng-model="selectedTimeperiod.value"></input>
								<div class="input-group-btn">
									<button data-toggle="dropdown" id="tp-list"
										class="btn btn-primary dropdown-toggle pull-left"
										type="button">
										<i class="fa fa-lg fa-calendar"></i>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="tp-list"
										id="tp_drop">
										<li ng-repeat="timeformat in timeformats"><a
											ng-click="selectTimeperiod(timeformat)" href="#">
												{{timeformat.value}}</a></li>
									</ul>
								</div>
								<!-- /btn-group -->
							</div>
						</div>

					</section>

					<!-- 					<section class="regiondistblock" data-html2canvas-ignore="true"> -->
					<!-- 						Radio buttons right -->
					<!-- 						<div class="btn-group" role="toolbar"> -->
					<!-- 							<button type="button" class="btn btn-info" -->
					<!-- 								ng-class="{Region: 'active'}[selectedMapAreaType]" -->
					<!-- 								ng-click="selectMapAreaType('Region')">Region</button> -->
					<!-- 							<button type="button" class="btn btn-info" -->
					<!-- 								ng-class="{District: 'active'}[selectedMapAreaType]" -->
					<!-- 								ng-click="selectMapAreaType('District')">District</button> -->
					<!-- 							<button type="button" class="btn btn-info" -->
					<!-- 								ng-class="{Block: 'active'}[selectedMapAreaType]" -->
					<!-- 								ng-click="selectMapAreaType('Block')">Block</button> -->
					<!-- 						</div> -->
					<!-- 					</section> -->

<!-- 					<button id="backBtn" type="button" -->
<!-- 						class="btn btn-default backbtn hidden mar-top-15" -->
<!-- 						data-html2canvas-ignore="true"> -->
<!-- 						<i class="fa fa-lg fa-arrow-circle-o-left"></i>Back -->
<!-- 					</button> -->
					<section>
					<div>
					<button type="button" class="btn btn-default btn-sm btn_low"
						ng-class="{State: 'active'}[selectedMapAreaType]"
						ng-click="selectMapAreaType('State')">State</button>
					<button type="button" class="btn btn-default btn-sm btn_low"
						ng-class="{District: 'active'}[selectedMapAreaType]"
						ng-click="selectMapAreaType('District')">District</button>
					</div>
					</section>
				</div>


				<section id="tbsection" class="topthree"
					ng-show="legends.length > 0" ng-hide="legends.length == 0">
					<div class="mar-bot-5"">
						<h4 class="top">Top 3</h4>
						<ul class="topperformers">
							<li ng-repeat="performer in topPerformers"><span>
									{{performer}}</span></li>
							<!-- 														<li><span> top2</span></li> -->
							<!-- 														<li><span> top3</span></li> -->
						</ul>
					</div>
					<div>
						<h4 class="bottom">Bottom 3</h4>
						<ul class="bottomperformers">
							<li ng-repeat="performer in bottomPerformers"><span>
									{{performer}}</span></li>
							<!-- 														<li><span> bottom2</span></li> -->
							<!-- 														<li><span> bottom3</span></li> -->
						</ul>
					</div>
				</section>


				<div class="col-sm-3 pull-right" id="right_exportshare">
					<jsp:include page="fragments/exportandShare.jsp">
						<jsp:param value="containerId" name="exportcontainer" />
						<jsp:param value="{{selectedGranularity.key}}" name="areaId" />
						<jsp:param value="{{selectedIndicator.description}}"
							name="indicatorId" />
						<jsp:param value="{{selectedTimeperiod.key}}" name="timePeriodId" />
						<jsp:param value="{{selectedSource.key}}" name="sourceId" />
                        <jsp:param value="sdg" name="computeType" />
						<jsp:param value="{{selectedGranularity.value}}" name="area" />
						<jsp:param value="{{selectedIndicator.value}}" name="indicator" />
						<jsp:param value="{{selectedTimeperiod.value}}" name="timePeriod" />
						<jsp:param value="{{selectedSource.value}}" name="source" />
						<jsp:param value="{{selectedChildAreaLevel}}"
							name="childAreaLevel" />
					</jsp:include>


					<section class="selection-desc">
						<br>
						<!-- 							<h3 class="top" data-html2canvas-ignore="true">{{selectedSector.value}}</h3> -->

   
<!-- 						<p data-html2canvas-ignore="true"> -->
						
						   
						  <div class="tooltips">
						   <span class=" glyphicon glyphicon-info-sign superscript" >
  								<span class="tooltiptexts">{{selectedIndicator.metadata.length!=0?selectedIndicator.metadata:'No Metadata available'}}</span>
							</span>
						  </div>
						  <span>{{selectedIndicator.value}}</span> 
<!-- 						</p> -->
						
						<!-- 						<p>{{selectedIndicator.description}}</p> -->
					</section>
				</div>
				<section>

					<div class="direction">
						<img class="img-responsive" alt="Responsive image"
							src="resources/images/north_arrow_new.png">
					</div>
				</section>


				<section id="legendsection" class="legends"
						ng-show="legends.length > 0" ng-hide="legends.length == 0">

					<h4>LEGEND</h4>
					<ul>
						<li ng-repeat="legend in legends" class="legend_list">
						<style>
						
						</style>
						<span class="legend_key">{{legend.key}}</span> <span
							class="{{legend.value}} legnedblock"> </span></li>
					</ul>
					
				</section>

				<!-- 				<section class="topthree hide_smooth " -->
				<!-- 					ng-class="{'show_smooth': topPerformers.length != 0 && topPerformers != null}"> -->
				<!-- 						<div class="container"> -->
				<!-- 					<div class="mar-bot-5""> -->
				<!-- 						<h4 class="top">Top 3</h4> -->
				<!-- 						<ul class="topperformers"> -->
				<!-- 							<li ng-repeat="performer in topPerformers"><span> -->
				<!-- 									{{performer}}</span></li> -->
				<!-- <!-- 														<li><span> top2</span></li> -->
				<!-- <!-- 														<li><span> top3</span></li> -->
				<!-- 						</ul> -->
				<!-- 					</div> -->
				<!-- 										<div> -->
				<!-- 											<h4 class="bottom">Bottom 3</h4> -->
				<!-- 											<ul class="bottomperformers"> -->
				<!-- 												<li ng-repeat="performer in bottomPerformers"><span> -->
				<!-- 														{{performer}}</span></li> -->
				<!-- <!-- 																			<li><span> bottom2</span></li> -->
				<!-- <!-- 																			<li><span> bottom3</span></li> -->
				<!-- 											</ul> -->
				<!-- 										</div></div> -->
				<!-- 				</section> -->
<!-- 				<section class="legends"> -->
<!-- 					<h4>LEGEND</h4> -->
<!-- 					<ul> -->
<!-- 						<li ng-repeat="legend in legends" class="legend_list"><span -->
<!-- 							class="legend_key">{{legend.key}}</span> <span -->
<!-- 							class="{{legend.value}} legnedblock"> </span></li> -->
<!-- 					</ul> -->

<!-- 				</section> -->


				<!-- End of right buttons -->
				<div class="map_popover">
					<div class="map_popover_close"></div>
					<div class="map_popover_content"></div>

				</div>
				<!-- Map loading portion -->
				<!-- 					<div class="map-container"> -->

				<div>
					<samiksha-map ng-style="style()"
						style="display:block;margin-top: -15px;"></samiksha-map>
					<!---- End of map loading portion -------->

				</div>
				<div class="bihar_line" data-html2canvas-ignore="true"
					ng-show="shoulddisappear">
					<i>Double click on Assam to view district data</i>
				</div>
				
				<div class="trend-viz animate-show" ng-animate=" 'animate' "
					ng-show="isTrendVisible">
					<button class="close" aria-hidden="true" type="button"
						ng-click="closeViz()">
						<span class="glyphicon glyphicon-remove-circle"></span>
					</button>

					<div class="container-fluid">
						<div class="row show-grid">
							<div class="col-xs-6 col-md-4 left">
								<h3>{{selectedArea.properties.SHORTNAME1_}}</h3>
							</div>
							<div class="col-xs-6 col-md-4 middle">
								<span>Rank:</span><span class="rank uptrend">
									{{selectedArea.properties.utdata.rank}}</span><span class="rank">
									<i class="of_txt">of</i>&nbsp; {{utdata.dataCollection.length}}
								</span>
							</div>
							<div class="col-xs-6 col-md-4 right"
								ng-show="PCldata.percentageChange">
								<span>{{PCldata.percentageChange}}
									%</span><i class="glyphicon glyphicon-arrow-up uptrend"
									ng-show="PCldata.isPositive || PCldata.percentageChange == 0.00"></i> 
									<i class="glyphicon glyphicon-arrow-down downtrend"
									ng-hide="PCldata.isPositive"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">

							<div class="line-separator"></div>

							<div class="row">
								<div class="col-md-10">
								<div class="col-sm-6 text-center" ng-repeat="data in ldata track by $index">
                                                               <samiksha-line dataprovider="data"></samiksha-line>
                                                       </div>
                               <div class="col-sm-6 text-center" ng-repeat="data in cldata">
                                                                       <sdrc-bar-chart dataprovider="data"></sdrc-bar-chart>
                                                               </div>
								
								
<!-- 									<div id="trendvizid" ng-show="isLineVisible"> -->
<!-- 										<samiksha-line></samiksha-line> -->
<!-- 									</div> -->
<!-- 									<div id="trendvizid" ng-show="isColumnVisible"> -->
<!-- 										<sdrc-bar-chart> </sdrc-bar-chart> -->
<!-- 									</div> -->
									<div class="col-md-2"></div>
								</div>

							</div>
						</div>
					</div>
				</div>
				
				
			</div>
			<div Style="height: 10px;"></div>
		</div>
	</div>
	<spring:url value="/webjars/angularjs/1.2.16/angular.min.js"
		var="angularmin" />
	<script src="${angularmin}" type="text/javascript"></script>
	<spring:url value="/webjars/angularjs/1.2.16/angular-animate.min.js"
		var="angularaAnimatemin" />
	<script src="${angularaAnimatemin}" type="text/javascript"></script>
<%-- 	<spring:url --%>
<%-- 		value="/webjars/angular-loading-bar/0.4.3/loading-bar.js" --%>
<%-- 		var="loadingbarmin" /> --%>
	<script src="resources/js/loading-bar.js" type="text/javascript"></script>
	<script src="${loadingbarmin}" type="text/javascript"></script>

	<spring:url value="/webjars/d3js/3.4.6/d3.min.js" var="d3js" />
	<script src="${d3js}"></script>

	<jsp:include page="fragments/footer.jsp" />

	<script src="resources/js/sdrc.dashboard.js" type="text/javascript"></script>
	<script src="resources/js/angcontrollers/sdgDashboardctrl.js"
		type="text/javascript"></script>
</body>

</html>
