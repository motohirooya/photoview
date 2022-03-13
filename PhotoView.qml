<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Actions" version="3.16.16-Hannover" labelsEnabled="1">
  <renderer-v2 type="RuleRenderer" enableorderby="0" forceraster="0" symbollevels="0">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('DistRank',   array_find(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;)&#xd;&#xa;END" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" label="PHOTO VIEW" symbol="0"/>
      <rule filter="ELSE" key="{11dde42b-66f3-4248-b456-51b3af11524f}" label="POINT" symbol="1"/>
      <rule filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2020/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2020/3/13 色の調整、コメントの記載&#xd;&#xa;&#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/" key="{3881f3a2-408f-4e64-84f6-d42475562fae}" label="POINT" symbol="2"/>
    </rules>
    <symbols>
      <symbol name="0" type="marker" force_rhr="0" alpha="0.6" clip_to_extent="1">
        <layer locked="0" enabled="1" class="GeometryGenerator" pass="6">
          <prop k="SymbolType" v="Line"/>
          <prop k="geometryModifier" v="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;)))))))&#xd;&#xa;"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol name="@0@0" type="line" force_rhr="0" alpha="1" clip_to_extent="1">
            <layer locked="0" enabled="1" class="SimpleLine" pass="0">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="square"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="MM"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="15,245,245,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="0.2"/>
              <prop k="line_width_unit" v="MM"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties"/>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="4">
          <prop k="angle" v="0"/>
          <prop k="color" v="15,245,245,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="5">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.6"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="GeometryGenerator" pass="7">
          <prop k="SymbolType" v="Marker"/>
          <prop k="geometryModifier" v="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;))))))&#xd;&#xa;"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol name="@0@3" type="marker" force_rhr="0" alpha="1" clip_to_extent="1">
            <layer locked="0" enabled="1" class="RasterMarker" pass="0">
              <prop k="alpha" v="1"/>
              <prop k="angle" v="0"/>
              <prop k="fixedAspectRatio" v="0"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="imageFile" v=""/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="MapUnit"/>
              <prop k="vertical_anchor_point" v="0"/>
              <effect type="effectStack" enabled="1">
                <effect type="dropShadow">
                  <prop k="blend_mode" v="13"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="0,0,0,255"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="offset_angle" v="135"/>
                  <prop k="offset_distance" v="2"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="offset_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="outerGlow">
                  <prop k="blend_mode" v="0"/>
                  <prop k="blur_level" v="0.5"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color1" v="0,0,255,255"/>
                  <prop k="color2" v="0,255,0,255"/>
                  <prop k="color_type" v="0"/>
                  <prop k="discrete" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="1"/>
                  <prop k="opacity" v="0.5"/>
                  <prop k="rampType" v="gradient"/>
                  <prop k="single_color" v="255,255,255,255"/>
                  <prop k="spread" v="1"/>
                  <prop k="spread_unit" v="MM"/>
                  <prop k="spread_unit_scale" v="3x:0,0,0,0,0,0"/>
                </effect>
                <effect type="drawSource">
                  <prop k="blend_mode" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="1"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="innerShadow">
                  <prop k="blend_mode" v="13"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="0,0,0,255"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="offset_angle" v="135"/>
                  <prop k="offset_distance" v="2"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="offset_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="innerGlow">
                  <prop k="blend_mode" v="0"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color1" v="0,0,255,255"/>
                  <prop k="color2" v="0,255,0,255"/>
                  <prop k="color_type" v="0"/>
                  <prop k="discrete" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="opacity" v="0.5"/>
                  <prop k="rampType" v="gradient"/>
                  <prop k="single_color" v="255,255,255,255"/>
                  <prop k="spread" v="2"/>
                  <prop k="spread_unit" v="MM"/>
                  <prop k="spread_unit_scale" v="3x:0,0,0,0,0,0"/>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="name" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="field" type="QString" value="photo"/>
                      <Option name="type" type="int" value="2"/>
                    </Option>
                    <Option name="width" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('Leader',if(@PhotoView_Leader is null, to_real(0.6),to_real(@PhotoView_Leader)),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;&#x9;@PhotoBySideMargin*@SideMargin)&#xd;&#xa;))))"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol name="1" type="marker" force_rhr="0" alpha="0.6" clip_to_extent="1">
        <layer locked="0" enabled="1" class="SimpleMarker" pass="2">
          <prop k="angle" v="0"/>
          <prop k="color" v="255,255,255,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="3">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.75"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="2" type="marker" force_rhr="0" alpha="0.6" clip_to_extent="1">
        <layer locked="0" enabled="1" class="SimpleMarker" pass="0">
          <prop k="angle" v="0"/>
          <prop k="color" v="179,179,179,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="1">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.75"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="rule-based">
    <rules key="{a8187c98-f13e-466e-bce2-0bd932726b66}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('DistRank',   array_find(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;)&#xd;&#xa;END" key="{21f43a16-d141-412f-8915-3399617f2e0d}" description="PhotoViewLabel">
        <settings calloutType="simple">
          <text-style fontSizeMapUnitScale="3x:0,0,0,0,0,0" textOrientation="horizontal" namedStyle="Regular" blendMode="0" fontSizeUnit="MapUnit" fontSize="10" fontLetterSpacing="0" fontUnderline="0" fontWeight="50" fontKerning="1" fontWordSpacing="0" textOpacity="1" previewBkgrdColor="255,255,255,255" textColor="0,0,0,255" fontStrikeout="0" allowHtml="0" fontItalic="0" capitalization="0" fieldName="filename" fontFamily="Arial" isExpression="0" multilineHeight="1" useSubstitutions="0">
            <text-buffer bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferNoFill="1" bufferOpacity="1" bufferJoinStyle="128" bufferSize="0.6" bufferSizeUnits="MM" bufferColor="250,250,250,255" bufferDraw="1" bufferBlendMode="0"/>
            <text-mask maskType="0" maskEnabled="0" maskSizeUnits="MM" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskOpacity="1" maskSize="0" maskedSymbolLayers="" maskJoinStyle="128"/>
            <background shapeOpacity="1" shapeJoinStyle="64" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetUnit="Point" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeRotation="0" shapeOffsetY="0" shapeSizeUnit="Point" shapeSizeY="0" shapeSVGFile="" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiY="0" shapeBorderColor="128,128,128,255" shapeBlendMode="0" shapeDraw="0" shapeBorderWidth="0" shapeSizeType="0" shapeBorderWidthUnit="Point" shapeRadiiUnit="Point" shapeType="0" shapeOffsetX="0" shapeRadiiX="0" shapeFillColor="255,255,255,255" shapeSizeX="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeRotationType="0">
              <symbol name="markerSymbol" type="marker" force_rhr="0" alpha="1" clip_to_extent="1">
                <layer locked="0" enabled="1" class="SimpleMarker" pass="0">
                  <prop k="angle" v="0"/>
                  <prop k="color" v="243,166,178,255"/>
                  <prop k="horizontal_anchor_point" v="1"/>
                  <prop k="joinstyle" v="bevel"/>
                  <prop k="name" v="circle"/>
                  <prop k="offset" v="0,0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="outline_color" v="35,35,35,255"/>
                  <prop k="outline_style" v="solid"/>
                  <prop k="outline_width" v="0"/>
                  <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="outline_width_unit" v="MM"/>
                  <prop k="scale_method" v="diameter"/>
                  <prop k="size" v="2"/>
                  <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="size_unit" v="MM"/>
                  <prop k="vertical_anchor_point" v="1"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" type="QString" value=""/>
                      <Option name="properties"/>
                      <Option name="type" type="QString" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </background>
            <shadow shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100" shadowRadiusUnit="MM" shadowUnder="0" shadowOffsetUnit="MM" shadowRadius="1.5" shadowDraw="0" shadowOffsetAngle="135" shadowRadiusAlphaOnly="0" shadowOpacity="0.7" shadowColor="0,0,0,255" shadowBlendMode="6" shadowOffsetDist="1" shadowOffsetGlobal="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0"/>
            <dd_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format formatNumbers="0" plussign="0" rightDirectionSymbol=">" leftDirectionSymbol="&lt;" decimals="3" reverseDirectionSymbol="0" autoWrapLength="0" placeDirectionSymbol="0" wrapChar="" useMaxLineLengthForAutoWrap="1" addDirectionSymbol="0" multilineAlign="3"/>
          <placement repeatDistanceUnits="MM" distMapUnitScale="3x:0,0,0,0,0,0" offsetUnits="MM" quadOffset="1" maxCurvedCharAngleIn="25" geometryGeneratorEnabled="1" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;))))))&#xd;&#xa;" priority="5" lineAnchorType="0" preserveRotation="1" polygonPlacementFlags="2" yOffset="0" maxCurvedCharAngleOut="-25" overrunDistance="0" geometryGeneratorType="PointGeometry" fitInPolygonOnly="0" dist="0" rotationAngle="0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" placement="1" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" placementFlags="10" overrunDistanceUnit="MM" centroidWhole="0" repeatDistance="0" distUnits="MM" xOffset="0" lineAnchorPercent="0.5" offsetType="1" layerType="PointGeometry" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" centroidInside="0"/>
          <rendering scaleVisibility="0" mergeLines="0" fontLimitPixelSize="0" scaleMin="0" obstacleType="1" labelPerPart="0" limitNumLabels="0" minFeatureSize="0" scaleMax="0" fontMinPixelSize="3" obstacle="1" upsidedownLabels="0" fontMaxPixelSize="10000" zIndex="0" maxNumLabels="2000" drawLabels="1" displayAll="0" obstacleFactor="1"/>
          <dd_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="Size" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('LabelSize',if(@PhotoView_LabelSize is null, to_real(6)*@map_scale/1000,to_real(@PhotoView_LabelSize)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('PhotoWidth',@PhotoBySideMargin*@SideMargin,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;&#x9;length( regexp_replace(  &quot;filename&quot; ,'[^\\x01-\\x7E\\xA1-\\xDF]','aa'))/2,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;&#x9;@LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option name="anchorPoint" type="QString" value="pole_of_inaccessibility"/>
              <Option name="ddProperties" type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
              <Option name="drawToAllParts" type="bool" value="false"/>
              <Option name="enabled" type="QString" value="0"/>
              <Option name="labelAnchorPoint" type="QString" value="point_on_exterior"/>
              <Option name="lineSymbol" type="QString" value="&lt;symbol name=&quot;symbol&quot; type=&quot;line&quot; force_rhr=&quot;0&quot; alpha=&quot;1&quot; clip_to_extent=&quot;1&quot;>&lt;layer locked=&quot;0&quot; enabled=&quot;1&quot; class=&quot;SimpleLine&quot; pass=&quot;0&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; type=&quot;QString&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; type=&quot;QString&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
              <Option name="minLength" type="double" value="0"/>
              <Option name="minLengthMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="minLengthUnit" type="QString" value="MM"/>
              <Option name="offsetFromAnchor" type="double" value="0"/>
              <Option name="offsetFromAnchorMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="offsetFromAnchorUnit" type="QString" value="MM"/>
              <Option name="offsetFromLabel" type="double" value="0"/>
              <Option name="offsetFromLabelMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="offsetFromLabelUnit" type="QString" value="MM"/>
            </Option>
          </callout>
        </settings>
      </rule>
    </rules>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <attributeactions>
    <defaultAction key="Canvas" value="{22410f64-335f-48c8-8d91-892485dc7635}"/>
    <actionsetting isEnabledOnlyWhenEditable="0" name="open" capture="0" type="5" action="[%photo%]" icon="" id="{22410f64-335f-48c8-8d91-892485dc7635}" notificationMessage="" shortTitle="">
      <actionScope id="Feature"/>
      <actionScope id="Field"/>
      <actionScope id="Canvas"/>
      <actionScope id="Layer"/>
    </actionsetting>
  </attributeactions>
  <layerGeometryType>0</layerGeometryType>
</qgis>
