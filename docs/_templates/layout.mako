## coding: utf-8

<%!
    local_script_files = []

    default_css_files = [
        '_static/pygments.css',
    ]
%>

<%doc>
    Structural elements are all prefixed with "docs-"
    to prevent conflicts when the structure is integrated into the
    main site.

    docs-container ->
        docs-top-navigation-container ->
            docs-header ->
                docs-version-header
            docs-top-navigation
                docs-top-page-control
                docs-navigation-banner
        docs-body-container ->
            docs-sidebar
            docs-body
        docs-bottom-navigation
            docs-copyright
</%doc>

<%inherit file="${context['base']}"/>

<%
    if builder == 'epub':
        next.body()
        return
%>


<%
withsidebar = bool(toc) and (
    theme_index_sidebar is True or current_page_name != 'index'
)
%>

<%block name="head_title">
    % if theme_index_sidebar or current_page_name != 'index':
    ${capture(self.show_title) | util.striptags} &mdash;
    % endif
    ${docstitle|h}
</%block>

<%def name="show_title()">
    ${title}
</%def>


<div id="docs-container" style="max-width: 1300px; min-width: 650px; width: 98%">


<%block name="headers">

    ${parent.headers()}

    <link rel="shortcut icon" type="image/x-icon"
    href="${pathto('_static/urfu-icon.png', 1)}" />
    <link rel="apple-touch-icon"
    href="${pathto('_static/apple-touch-icon.png', 1)}" />

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="yandex-verification" content="487487bc449cadc7" />
    <meta name="yandex-verification" content="1e40e2b274866636" />
    <meta name="yandex-verification" content="770dff2ea8dc9e6e" />
    <meta name="yandex-verification" content="1e54fdde37696930" />
    <meta name="yandex-verification" content="e5a3017b02116b65" />
    <meta name="google-site-verification" content="ULhgwatYB_2i-_WD1bHyhiL6wMylvcu_TNm54byi8jU" />

    <!-- begin layout.mako headers -->

    % if hasdoc('about'):
        <link rel="author" title="${_('About these documents')}" href="${pathto('about')}" />
    % endif
    <link rel="index" title="${_('Index')}" href="${pathto('genindex')}" />
    <link rel="search" title="${_('Search')}" href="${pathto('search')}" />
    % if hasdoc('copyright'):
        <link rel="copyright" title="${_('Copyright')}" href="${pathto('copyright')}" />
    % endif
    <link rel="top" title="${docstitle|h}" href="${pathto('index')}" />
    % if parents:
        <link rel="up" title="${parents[-1]['title']|util.striptags}" href="${parents[-1]['link']|h}" />
    % endif
    % if nexttopic:
        <link rel="next" title="${nexttopic['title']|util.striptags}" href="${nexttopic['link']|h}" />
    % endif
    % if prevtopic:
        <link rel="prev" title="${prevtopic['title']|util.striptags}" href="${prevtopic['link']|h}" />
    % endif
    <!-- end layout.mako headers -->

</%block>

<div id="docs-top-navigation-container" class="body-background">
<div id="docs-header">
  % if withsidebar:
    <a href="${pathto('index')}" style="margin-left:30px">Домой</a>
    <a href="${context['show_on_github_url']}">
      <img style="position: absolute; top: 0; right: 0; border: 0; z-index: 100; width: 110px"
      src="${pathto('_static/edit-me-on-github.png', 1)}" alt="Edit me on GitHub">
    </a>
  %else:
    <h1>${docstitle|h}</h1>
  %endif

  <div id="sidebar-search" style="margin-left:50px">
    <form class="search" action="${pathto('search')}" method="get">
      <label>
        <input type="text" placeholder="search..." name="q" size="28" />
      </label>
      <input type="submit" value="${_('Search')}" />
      <input type="hidden" name="check_keywords" value="yes" />
      <input type="hidden" name="area" value="default" />
    </form>
  </div>

  ## <div style="margin: 0 auto">
  ##   <script type="text/javascript" src="/_static/js/orphus.js"></script>
  ##   <a href="//orphus.ru" id="orphus" target="_blank" style="margin-left:20px">
  ##     <img alt="Система Orphus" src="/_static/img/orphus.gif"
  ##     border="0" width="240" height="80" />
  ##   </a>
  ## </div>

  % if withsidebar:
    <div style="margin-left: auto; margin-right: 50px; margin-top: 50px">
      ##id="docs-version-header">
      ## Release: <span class="version-num">${release}</span>
      % if release_date:
        <div style="font-size: 0.7em;margin-top:5px">
          <p> ${release_date} </p>
        </div>
      ## % else:
      ## | Release Date: unreleased
      % endif
    </div>
  % else:
    <div style="margin-left: auto; margin-right: 10px;">
    <div style="margin-right: 20px">
      <a class="github-button"
        href="https://github.com/ustu/lectures.www" data-size="large"
        data-show-count="true" aria-label="Star ustu/lectures.www on GitHub">Star</a>
    </div>
    % if release_date:
      <div style="font-size: 0.7em;margin-top:5px;text-align: right">
        <p> ${release_date} </p>
      </div>
    % endif
    </div>
  % endif


</div>
</div>

% if withsidebar:
<div id="hide-sidebar" style="margin-top:20px;position:fixed;margin-left:-59px;background:#e7ff00;width:40px;text-align:left">
  <button id="hide-sidebar-button" onclick="toggleHideSideBar()" style="background:#aaffaa">Hide <<</button>
</div>
% endif

<div id="docs-body-container">

    <div id="fixed-sidebar" class="${'withsidebar' if withsidebar else ''}">

    % if withsidebar:
      <div id="docs-sidebar-popout" style="height: 221px;max-height: 250px; width: 288px;">
        <div id="yandex-partner" style="margin-left:-11px;margin-top:-28px"></div>
      </div>

      <div id="docs-sidebar" style="top: 238px; width: 300px">

        <div id="sidebar-banner">
          %if hasattr(parent, "bannerad"):
            ${parent.bannerad()}
          %endif
        </div>

        <div id="docs-sidebar-inner">

          <%
            breadcrumb = parents[:]
            if not breadcrumb or breadcrumb[0]['link'] != pathto('index'):
                breadcrumb = [{'link': pathto('index'), 'title': docstitle}] + breadcrumb

            if len(breadcrumb) > 1:
                breadcrumb = breadcrumb[1:]
            h3_toc_item = breadcrumb[0]
            if len(breadcrumb) > 1:
                outermost_link_item = breadcrumb[1]['link']
            elif not parents:
                outermost_link_item = None
            else:
                outermost_link_item = ''

          %>
          <h3>
            <a href="${h3_toc_item['link']|h}" title="${h3_toc_item['title']}">${h3_toc_item['title']}</a>
          </h3>

          ${parent_toc(
          current_page_name,
          outermost_link_item)}

          % if rtd:
            <h4>Project Versions</h4>
            <ul class="version-listing">
              <li><a href="${pathto('index')}">${release}</a></li>
            </ul>
          % endif

        </div>

      </div>
    % endif

    </div>

    <%doc>
    <div id="docs-top-navigation">
        <a href="${pathto('index')}">${docstitle|h}</a>
        % if parents:
            % for parent in parents:
                » <a href="${parent['link']|h}" title="${parent['title']}">${parent['title']}</a>
            % endfor
        % endif
        % if current_page_name != 'index':
        » ${self.show_title()}
        % endif

        <h2>
            <%block name="show_title">
                ${title}
            </%block>
        </h2>

    </div>
    </%doc>


    % if withsidebar:
      <div id="docs-body" class="${'withsidebar' if withsidebar else ''}"
           style="margin-left: 314px;margin-top: 16px !important" >
        <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
        <script src="//yastatic.net/share2/share.js"></script>
        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,gplus,twitter,telegram" data-counter=""></div>
    % else:
      <div id="docs-body" class="${'withsidebar' if withsidebar else ''}">
    % endif
        ${next.body()}
    </div>

</div>

    % if withsidebar:
    <div id="disqus_thread" style="margin-left:320px;"></div>
    <script async type="text/javascript">
        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        var disqus_shortname = 'wwwlectures'; // required: replace example with your forum shortname
        var disqus_identifier = document.title;
        var disqus_title = document.title;
        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    </script>
    %endif

    <div id="docs-bottom-navigation" class="docs-navigation-links${', withsidebar' if withsidebar else ''}" style="margin-left: 320px">
    % if prevtopic:
        Previous:
        <a href="${prevtopic['link']|h}" title="${_('previous chapter')}">${prevtopic['title']}</a>
    % endif
    % if nexttopic:
        Next:
        <a href="${nexttopic['link']|h}" title="${_('next chapter')}">${nexttopic['title']}</a>
    % endif

    <div id="docs-copyright">
    % if hasdoc('copyright'):
        &copy; <a href="${pathto('copyright')}">Copyright </a> ${copyright|h}.
    % else:
        &copy; Copyright ${copyright|h}.
    % endif
    % if show_sphinx:
        Created using <a href="http://sphinx.pocoo.org/">Sphinx</a> ${sphinx_version|h}.
    % endif
    </div>
</div>

</div>

<%block name="lower_scripts">

    <!-- begin iterate through sphinx environment script_files -->
    % for scriptfile in script_files + self.attr.local_script_files:
      % if "_static/js" in pathto(scriptfile, 1):
        <script async type="text/javascript" src="${pathto(scriptfile, 1)}"></script>
      %else:
        <script type="text/javascript" src="${pathto(scriptfile, 1)}"></script>
      %endif
    % endfor
    <!-- end iterate through sphinx environment script_files -->

    <script type="text/javascript" src="${pathto('_static/detectmobile.js', 1)}"></script>
    <script type="text/javascript" src="${pathto('_static/init.js', 1)}"></script>

    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script async type="text/javascript">
      var DOCUMENTATION_OPTIONS = {
          URL_ROOT:    '${pathto("", 1)}',
          VERSION:     '${release|h}',
          COLLAPSE_MODINDEX: false,
          FILE_SUFFIX: '${file_suffix}'
      };
    </script>

    <script async type="text/javascript">
      var sidebar = document.getElementById('fixed-sidebar');
      var docsBody = document.getElementById('docs-body');
      var button = document.getElementById('hide-sidebar-button');
      var discusThread = document.getElementById('disqus_thread');
      function toggleHideSideBar() {
        if (sidebar.style.display != 'none') {
          sidebar.style.display = 'none';
          docsBody.style['margin-left'] = '0px';
          discusThread.style['margin-left'] = '0px';
          button.innerHTML = "Show >>";
        } else {
          sidebar.style.display = 'block';
          docsBody.style['margin-left'] = '314px';
          discusThread.style['margin-left'] = '320px';
          button.innerHTML = "Hide <<";
        }
      };
    </script>

</%block>
