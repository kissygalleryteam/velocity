module.exports = (grunt)->

  grunt.initConfig
    pkg: grunt.file.readJSON('abc.json')
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd h:MM:ss TT") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'

    kmc:
      options:
        packages: [
          name: '<%= pkg.name %>'
          path: '../'
        ]
      files: [
        src: "<%= pkg.version %>/index.js"
        dest: "<%= pkg.version %>/index.combo.js"
      ,
        src: "<%= pkg.version %>/parse.js"
        dest: "<%= pkg.version %>/parse.combo.js"
      ]

    uglify:
      options:
        banner: '<%= banner %>'
      base:
        files:
          '<%= pkg.version %>/index-min.js': ['<%= pkg.version %>/index.js']
          '<%= pkg.version %>/parse-min.js': ['<%= pkg.version %>/parse.js']
    copy:
      main:
        files: [
          expand: true
          cwd: '<%= pkg.version %>/'
          src: ['*.js']
          dest: '<%=pkg.version %>/build/'
          filter: 'isFile'
        ]
    clean:
      build: ["<%= pkg.version %>/*-min.js"]

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-kmc')

  grunt.registerTask 'default', ['uglify', 'copy', 'clean']
