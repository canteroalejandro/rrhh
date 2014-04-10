app = angular.module("app", [ "xeditable", "ngMockE2E" ])

app.run (editableOptions, editableThemes) ->
  editableThemes.bs2.cancelTpl = '<button type="button" class="btn btn-small" ng-click="$form.$cancel()"><span class="icon-remove"></span></button>'
  editableThemes.bs2.submitTpl = '<button type="submit" class="btn btn-small btn-primary"><span class="icon-ok icon-white"></span></button>'
  editableOptions.theme = "bs2"

app.controller "Ctrl", ($scope, $filter, $http) ->
  $scope.items_de_servicios = [
    servicio: null
    bonificacion: 0
  ]

  $scope.servicios = []

  $scope.paquete_de_servicio = null

  $scope.total = 0
  
  $scope.bonificacion = 0

  $scope.loadPaqueteDeServicio = (cb) ->
    if $scope.paquete_de_servicio then null else $http.get("/contadors/1/clientes/1/paquete_de_servicio_activo.json").success (data) ->
      $scope.paquete_de_servicio = data
      cb?(data)

  $scope.loadServicios = (cb) ->
    if $scope.servicios.length then null else $http.get("/contadors/1/servicios.json").success (data) ->
      $scope.servicios = data
      cb?(data)

  $scope.buscarObjectById = (id_a_buscar, lista)->
    selected = $filter("filter")(lista, { id: id_a_buscar })[0]

  _buscarObjectByAtributo = (id_a_buscar, atrib_lista, lista)->
    params = {}
    params[atrib_lista] = id_a_buscar
    selected = $filter("filter")(lista, params)[0]

  _getMontoServicio = (id_servicio)->
    if $scope.servicios.length == 0
      $scope.loadServicios (data)->
        s = $scope.buscarObjectById id_servicio, data
        if $scope.paquete_de_servicio is null
          $scope.loadPaqueteDeServicio (data)->
            s = _buscarObjectByAtributo id_servicio, "servicio_id", data.item_de_servicios
            if s 
              return s.monto_establecido
            else 
              s = $scope.buscarObjectById id_servicio, $scope.servicios
              return s.monto
    else
      if $scope.paquete_de_servicio isnt null
        s = $scope.buscarObjectById id_servicio, $scope.paquete_de_servicio.item_de_servicios
        0
  $scope.showServicio = (item_de_servicio) ->
    if item_de_servicio.servicio
      if $scope.servicios.length == 0
        $scope.loadServicios (data)->
          s = $scope.buscarObjectById item_de_servicio.servicio, data
          if s then s.descripcion else "Not set"
      else
        s = $scope.buscarObjectById item_de_servicio.servicio, $scope.servicios
        if s then s.descripcion else "Not set"
    else
      "Not Set"

  $scope.showMontoServicio = (item_de_servicio)->
    if item_de_servicio.servicio
      if $scope.servicios.length == 0
        $scope.loadServicios (data)->
          s = $scope.buscarObjectById item_de_servicio.servicio, data
          if s then s.monto else "Not set"
      else
        s = $scope.buscarObjectById item_de_servicio.servicio, $scope.servicios
        if s then s.monto else "Not set"
    else
      "Not Set"

  $scope.showMontoServicioBonificado = (item_de_servicio)->
    if item_de_servicio.servicio
      if $scope.paquete_de_servicio is null
        $scope.loadPaqueteDeServicio (data)->
          s = _buscarObjectByAtributo item_de_servicio.servicio, "servicio_id", data.item_de_servicios
          if s then s.monto_establecido else "No incluido"
      else
        s = _buscarObjectByAtributo item_de_servicio.servicio, "servicio_id", $scope.paquete_de_servicio.item_de_servicios
        if s then s.monto_establecido else "No incluido"
    else
      "Not Set"

  $scope.calcularBonificacion = (ids)->
    if ids.monto_establecido
      if $scope.servicios.length == 0
        $scope.loadServicios (data)->
          s = $scope.buscarObjectById item_de_servicio.servicio, data
          (s.monto - ids.monto_establecido)
      else
        s = $scope.buscarObjectById ids.servicio, $scope.servicios
        (s.monto - ids.monto_establecido)

  $scope.showBonif = (index)->
    console.log $scope.items_de_servicios[index].bonificacion
    $scope.items_de_servicios[index].bonificacion
    

  $scope.removeServicio = (index) ->
    $scope.items_de_servicios.splice index, 1

  $scope.addUser = ->
    $scope.inserted =
      servicio: null
    $scope.items_de_servicios.push $scope.inserted

  isNumber = (n) ->
    not isNaN(parseFloat(n)) and isFinite(n)

  $scope.calcularSubTotal = ->   
    if $scope.paquete_de_servicio isnt null
      servicios_id = $scope.items_de_servicios.map (a) -> a.servicio
      precios = servicios_id.map (id) ->
        s = _buscarObjectByAtributo id, "servicio_id", $scope.paquete_de_servicio.item_de_servicios
        unless s?
          s = $scope.buscarObjectById id, $scope.servicios
        if s.monto_establecido? then parseFloat(s.monto_establecido) else parseFloat(s.monto)
      precios.reduce(((a, b) -> a + b), 0) - $scope.bonificacion
    else
      0

  $scope.calcularTotal = ->   
    if $scope.paquete_de_servicio isnt null
      servicios_id = $scope.items_de_servicios.map (a) -> a.servicio
      precios = servicios_id.map (id) ->
        s = _buscarObjectByAtributo id, "servicio_id", $scope.paquete_de_servicio.item_de_servicios
        unless s?
          s = $scope.buscarObjectById id, $scope.servicios
        if s.monto_establecido? then parseFloat(s.monto_establecido) else parseFloat(s.monto)
      precios.reduce(((a, b) -> a + b), 0) - $scope.bonificacion
    else
      0

app.run ($httpBackend) ->
  $httpBackend.whenGET("/contadors/1/servicios.json").respond [
    contador_id: 1
    created_at: "2013-11-24T12:15:08Z"
    descripcion: "Impuestos"
    id: 1
    monto: "4000.0"
    updated_at: "2013-11-24T12:15:08Z"
  ,
    contador_id: 1
    created_at: "2013-11-24T12:15:17Z"
    descripcion: "Ganancias"
    id: 2
    monto: "3400.0"
    updated_at: "2013-11-24T12:15:17Z"
  ,
    contador_id: 1
    created_at: "2013-11-27T09:20:59Z"
    descripcion: "ja"
    id: 3
    monto: "2.0"
    updated_at: "2013-11-27T09:20:59Z"
  ]

  $httpBackend.whenGET("/contadors/1/clientes/1/paquete_de_servicio_activo.json").respond
    activo: null
    cliente_id: 1
    contador_id: 1
    created_at: "2013-11-27T05:22:53Z"
    descripcion: "otroPaquete"
    id: 46
    item_de_servicios: [
      created_at: "2013-11-27T05:22:53Z"
      id: 29
      monto_establecido: "2000.0"
      paquete_de_servicio_id: 46
      servicio_id: 1
      updated_at: "2013-11-27T05:22:53Z"
    ,
      created_at: "2013-11-27T05:22:53Z"
      id: 30
      monto_establecido: "3000.0"
      paquete_de_servicio_id: 46
      servicio_id: 2
      updated_at: "2013-11-27T05:22:53Z"
    ]
    item_de_servicios_id: null
    monto: "4000.0"
    updated_at: "2013-11-27T05:22:53Z"