prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>1830538872652277
,p_default_application_id=>1006
,p_default_id_offset=>58689188019173003
,p_default_owner=>'FXO'
);
end;
/
 
prompt APPLICATION 1006 - Organization Hierarchy
--
-- Application Export:
--   Application:     1006
--   Name:            Organization Hierarchy
--   Date and Time:   21:39 Tuesday July 6, 2021
--   Exported By:     KARKUVELRAJA.T
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 179994498134657384
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     218248527712390
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/orclking_image_magnifier_glass
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(179994498134657384)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'ORCLKING.IMAGE.MAGNIFIER.GLASS'
,p_display_name=>'Image Magnifier Glass'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_image_magnifier_glass (',
'    p_item                IN apex_plugin.t_page_item,',
'    p_plugin              IN apex_plugin.t_plugin,',
'    p_value               IN VARCHAR2,',
'    p_is_readonly         IN BOOLEAN,',
'    p_is_printer_friendly IN BOOLEAN )',
'    RETURN apex_plugin.t_page_item_render_result ',
'    ',
'  AS  ',
'    l_result    apex_plugin.t_page_item_render_result;',
'    l_page_item_name    VARCHAR2(100);  ',
'    l_html  CLOB;',
'    l_img_link    apex_application_page_items.attribute_01%type := p_item.attribute_01;',
'    l_img_width    apex_application_page_items.attribute_02%type := p_item.attribute_02; ',
'    l_img_height    apex_application_page_items.attribute_03%type := p_item.attribute_03;',
'    l_zoom    apex_application_page_items.attribute_04%type := p_item.attribute_04;',
'    l_glass_color    apex_application_page_items.attribute_05%type := p_item.attribute_05;',
'    l_glass_size    apex_application_page_items.attribute_06%type := p_item.attribute_06;',
'    l_glass_width NUMBER;',
'    l_glass_height NUMBER;',
'  BEGIN',
'    -- Debug information (if app is being run in debug mode)',
'    IF apex_application.g_debug THEN',
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,',
'                                        p_page_item             => p_item,',
'                                        p_value                 => p_value,',
'                                        p_is_readonly           => p_is_readonly,',
'                                        p_is_printer_friendly   => p_is_printer_friendly);',
'    END IF;',
'    ',
'    -- handle read only and printer friendly',
'    IF p_is_readonly OR p_is_printer_friendly THEN',
'      -- omit hidden field if necessary',
'      apex_plugin_util.print_hidden_if_readonly (p_item_name             => p_item.name,',
'                                                 p_value                 => p_value,',
'                                                 p_is_readonly           => p_is_readonly,',
'                                                 p_is_printer_friendly   => p_is_printer_friendly);',
'      -- omit display span with the value',
'      apex_plugin_util.print_display_only (p_item_name          => p_item.NAME,',
'                                           p_display_value      => p_value,',
'                                           p_show_line_breaks   => FALSE,',
'                                           p_escape             => TRUE, -- this is recommended to help prevent XSS',
'                                           p_attributes         => p_item.element_attributes);',
'    ELSE',
'      -- Not read only',
'      -- Get name. Used in the "name" form element attribute which is different than the "id" attribute ',
'      l_page_item_name := apex_plugin.get_input_name_for_page_item (p_is_multi_value => FALSE);',
'',
'      IF l_glass_size = ''S'' THEN -- Small',
'         l_glass_width := 70;',
'         l_glass_height := 70;',
'      elsIF l_glass_size = ''M'' THEN -- Medium',
'         l_glass_width := 120;',
'         l_glass_height := 120;',
'      elsIF l_glass_size = ''L'' THEN -- Large',
'         l_glass_width := 200;',
'         l_glass_height := 200;    ',
'      end if;         ',
'      ',
'       IF l_glass_color = ''B'' THEN -- Black',
'         l_glass_color := ''#000'';',
'      elsIF l_glass_color = ''W'' THEN -- White',
'         l_glass_color := ''white'';',
'      end if; ',
'      ',
'      -- Print Image Magnifier Glass',
'      ',
'      l_html := ''<!DOCTYPE html>',
'            <html>',
'            <head>',
'            <meta name="viewport" content="width=device-width, initial-scale=1.0">',
'            <style>',
'            * {box-sizing: border-box;}',
'',
'            .img-magnifier-container {',
'              position:relative;',
'            }',
'',
'            .img-magnifier-glass {',
'              position: absolute;',
'              border: 3px solid ''||nvl(l_glass_color,''#000'')||'';',
'              border-radius: 50%;',
'              cursor: none;',
'              /*Set the size of the magnifier glass:*/',
'              width: ''||nvl(l_glass_width,100)||''px;',
'              height: ''||nvl(l_glass_height,100)||''px;',
'            }',
'            </style>',
'            <script>',
'            function magnify(imgID, zoom) {',
'              var img, glass, w, h, bw;',
'              img = document.getElementById(imgID);',
'              /*create magnifier glass:*/',
'              glass = document.createElement("DIV");',
'              glass.setAttribute("class", "img-magnifier-glass");',
'              /*insert magnifier glass:*/',
'              img.parentElement.insertBefore(glass, img);',
'              /*set background properties for the magnifier glass:*/',
'              glass.style.backgroundImage = "url(''''" + img.src + "'''')";',
'              glass.style.backgroundRepeat = "no-repeat";',
'              glass.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";',
'              bw = 3;',
'              w = glass.offsetWidth / 2;',
'              h = glass.offsetHeight / 2;',
'              /*execute a function when someone moves the magnifier glass over the image:*/',
'              glass.addEventListener("mousemove", moveMagnifier);',
'              img.addEventListener("mousemove", moveMagnifier);',
'              /*and also for touch screens:*/',
'              glass.addEventListener("touchmove", moveMagnifier);',
'              img.addEventListener("touchmove", moveMagnifier);',
'              function moveMagnifier(e) {',
'                var pos, x, y;',
'                /*prevent any other actions that may occur when moving over the image*/',
'                e.preventDefault();',
'',
'                pos = getCursorPos(e);',
'                x = pos.x;',
'                y = pos.y;',
'                /*prevent the magnifier glass from being positioned outside the image:*/',
'                if (x > img.width - (w / zoom)) {x = img.width - (w / zoom);}',
'                if (x < w / zoom) {x = w / zoom;}',
'                if (y > img.height - (h / zoom)) {y = img.height - (h / zoom);}',
'                if (y < h / zoom) {y = h / zoom;}',
'                /*set the position of the magnifier glass:*/',
'                glass.style.left = (x - w) + "px";',
'                glass.style.top = (y - h) + "px";',
'                /*display what the magnifier glass "sees":*/',
'                glass.style.backgroundPosition = "-" + ((x * zoom) - w + bw) + "px -" + ((y * zoom) - h + bw) + "px";',
'              }',
'              function getCursorPos(e) {',
'                var a, x = 0, y = 0;',
'                e = e || window.event;',
'                /*get the x and y positions of the image:*/',
'                a = img.getBoundingClientRect();',
'',
'                x = e.pageX - a.left;',
'                y = e.pageY - a.top;',
'                /*consider any page scrolling:*/',
'                x = x - window.pageXOffset;',
'                y = y - window.pageYOffset;',
'                return {x : x, y : y};',
'              }',
'            }',
'            </script>',
'            </head>',
'            <body>',
'',
'',
'            <div class="img-magnifier-container">',
unistr('              <img id="myimage_''||l_page_item_name||''" src="''||nvl(l_img_link,''http://2.bp.blogspot.com/-g4u7SML5N1Q/X9nObb_hJzI/AAAAAAAAXjU/lKdcY4WSp7Iq0\20261600/purepng.com-oracle-logologobrand-logoiconslogos-251519939816xngul.png'')||''" width="''||nvl(')
||'l_img_width,600)||''" height="''||nvl(l_img_height,400)||''">',
'            </div>',
'',
'            <script>',
'            /* Initiate Magnify Function',
'            with the id of the image, and the strength of the magnifier glass:*/',
'            magnify("myimage_''||l_page_item_name||''",''||nvl(l_zoom,3)||'');',
'            </script>',
'            </body>',
'            </html>'';',
'      ',
'      l_result.is_navigable := FALSE;',
'    END IF; ',
'    sys.htp.p(l_html);',
'    RETURN l_result;',
'  END render_image_magnifier_glass;',
'  '))
,p_api_version=>1
,p_render_function=>'render_image_magnifier_glass'
,p_standard_attributes=>'VISIBLE:ELEMENT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/tkarkuvelraja/image_magnifier_glass_region_apex_plugin'
,p_files_version=>8
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(180004313276709509)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Img. Link'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'http://2.bp.blogspot.com/-g4u7SML5N1Q/X9nObb_hJzI/AAAAAAAAXjU/lKdcY4WSp7Iq04B_k4k3qzCGRi3mUXb6QCK4BGAYYCw/s1600/purepng.com-oracle-logologobrand-logoiconslogos-251519939816xngul.png'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(180004838362710495)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Img. Width'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'600'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(180005367252711042)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Img. Height'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'400'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(175112316580057471)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Zoom'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'3'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175112695569058080)
,p_plugin_attribute_id=>wwv_flow_api.id(175112316580057471)
,p_display_sequence=>10
,p_display_value=>'1'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175113089704058557)
,p_plugin_attribute_id=>wwv_flow_api.id(175112316580057471)
,p_display_sequence=>20
,p_display_value=>'2'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175113484606058911)
,p_plugin_attribute_id=>wwv_flow_api.id(175112316580057471)
,p_display_sequence=>30
,p_display_value=>'3'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175113815649059276)
,p_plugin_attribute_id=>wwv_flow_api.id(175112316580057471)
,p_display_sequence=>40
,p_display_value=>'4'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(175127726244586737)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Glass Color'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'B'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175128358210587328)
,p_plugin_attribute_id=>wwv_flow_api.id(175127726244586737)
,p_display_sequence=>10
,p_display_value=>'Black'
,p_return_value=>'B'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175128738107587746)
,p_plugin_attribute_id=>wwv_flow_api.id(175127726244586737)
,p_display_sequence=>20
,p_display_value=>'White'
,p_return_value=>'W'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(175129343311589712)
,p_plugin_id=>wwv_flow_api.id(179994498134657384)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Glass Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'M'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175129905393590158)
,p_plugin_attribute_id=>wwv_flow_api.id(175129343311589712)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'S'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175130364513590698)
,p_plugin_attribute_id=>wwv_flow_api.id(175129343311589712)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'M'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(175130770202591157)
,p_plugin_attribute_id=>wwv_flow_api.id(175129343311589712)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'L'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
