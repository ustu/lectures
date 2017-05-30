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

    <meta name="yandex-verification" content="487487bc449cadc7" />

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
    <div id="docs-version-header">
        <a class="github-button" href="https://github.com/ustu/lectures.www" data-size="large" data-show-count="true" aria-label="Star ustu/lectures.www on GitHub">Star</a>
        ## Release: <span class="version-num">${release}</span>
        % if release_date:
            ${release_date}
        ## % else:
        ## | Release Date: unreleased
        % endif

    </div>

    % if withsidebar:
        <a href="${pathto('index')}" style="margin-left:30px">Домой</a>
        <div id="sidebar-search" style="margin-left:50px">
            <form class="search" action="${pathto('search')}" method="get">
                <label>
                    <input type="text" placeholder="search..." name="q" size="50" />
                </label>
                <input type="hidden" name="check_keywords" value="yes" />
                <input type="hidden" name="area" value="default" />
            </form>
        </div>
    %else:
        <h1>${docstitle|h}</h1>
    %endif

</div>
</div>

<div id="docs-body-container">

    <div id="fixed-sidebar" class="${'withsidebar' if withsidebar else ''}">

    % if not withsidebar:
        <div id="index-nav">
            <form class="search" action="${pathto('search')}" method="get">
              <label>
                 Search terms:
              <input type="text" placeholder="search..." name="q" size="12" />
              </label>
              <input type="submit" value="${_('Search')}" />
              <input type="hidden" name="check_keywords" value="yes" />
              <input type="hidden" name="area" value="default" />
            </form>

            <p>
            <a href="${pathto('contents') or pathto('index')}">Contents</a> |
            <a href="${pathto('genindex')}">Index</a>
            % if pdf_url:
            | <a href="${pdf_url}">Download as PDF</a>
            % endif
            </p>

        </div>
    % endif

    % if withsidebar:
      <div id="docs-sidebar-popout" style="height: 250px;max-height: 250px; width: 288px;">
<!-- Yandex.RTB R-A-222712-1 -->
<div id="yandex_rtb_R-A-222712-1" style="margin-left:-11px;margin-top:-17px"></div>
<script type="text/javascript">
    (function(w, d, n, s, t) {
        w[n] = w[n] || [];
        w[n].push(function() {
            Ya.Context.AdvManager.render({
                blockId: "R-A-222712-1",
                renderTo: "yandex_rtb_R-A-222712-1",
                horizontalAlign: false,
                async: true
            });
        });
        t = d.getElementsByTagName("script")[0];
        s = d.createElement("script");
        s.type = "text/javascript";
        s.src = "//an.yandex.ru/system/context.js";
        s.async = true;
        t.parentNode.insertBefore(s, t);
    })(this, this.document, "yandexContextAsyncCallbacks");
</script>
        </div>

        <div id="docs-sidebar" style="top: 268px; width: 300px">

        <div id="sidebar-banner">
            ${parent.bannerad()}
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
      <div id="docs-body" class="${'withsidebar' if withsidebar else ''}" style="margin-left: 320px;margin-top: 16px !important" >
    % else:
      <div id="docs-body" class="${'withsidebar' if withsidebar else ''}">
    % endif
        ${next.body()}
    </div>

</div>

    % if withsidebar:
    <div id="disqus_thread" style="margin-left:320px;"></div>
    <script type="text/javascript">
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

    <script type="text/javascript">
      var DOCUMENTATION_OPTIONS = {
          URL_ROOT:    '${pathto("", 1)}',
          VERSION:     '${release|h}',
          COLLAPSE_MODINDEX: false,
          FILE_SUFFIX: '${file_suffix}'
      };
    </script>

    <!-- begin iterate through sphinx environment script_files -->
    % for scriptfile in script_files + self.attr.local_script_files:
        <script type="text/javascript" src="${pathto(scriptfile, 1)}"></script>
    % endfor
    <!-- end iterate through sphinx environment script_files -->

    <script type="text/javascript" src="${pathto('_static/detectmobile.js', 1)}"></script>
    <script type="text/javascript" src="${pathto('_static/init.js', 1)}"></script>

    <script async defer src="https://buttons.github.io/buttons.js"></script>

</%block>
