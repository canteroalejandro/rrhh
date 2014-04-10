app = angular.module("app", [ "xeditable", "ngMockE2E" ])

app.run (editableOptions, editableThemes) ->
  editableThemes.bs2.cancelTpl = '<button type="button" class="btn btn-small" ng-click="$form.$cancel()"><span class="icon-remove"></span></button>'
  editableThemes.bs2.submitTpl = '<button type="submit" class="btn btn-small btn-primary"><span class="icon-ok icon-white"></span></button>'
  editableOptions.theme = "bs2"

app.controller "Ctrl", ($scope, $filter, $http) ->
  $scope.items_de_servicios = [
    servicio: null
    monto_establecido: 0
  ]

  $scope.groups = []
  $scope.servicios = []
   
  $scope.loadServicios = (cb) ->
    if $scope.servicios.length then null else $http.get("/contadors/1/servicios.json").success (data) ->
      $scope.servicios = data
      cb?(data)

  $scope.buscarObjectById = (id_a_buscar, lista)->
    selected = $filter("filter")(lista, { id: id_a_buscar })[0]

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

  $scope.calcularBonificacion = (ids)->
    if ids.monto_establecido
      if $scope.servicios.length == 0
        $scope.loadServicios (data)->
          s = $scope.buscarObjectById item_de_servicio.servicio, data
          (s.monto - ids.monto_establecido)
      else
        s = $scope.buscarObjectById ids.servicio, $scope.servicios
        (s.monto - ids.monto_establecido)

  $scope.showStatus = (user) ->
    selected = []
    if user.status
      selected = $filter("filter")($scope.statuses,{value: user.status})
    (if selected.length then selected[0].text else "Not set")

  $scope.checkName = (data, id) ->
    "Username 2 should be `awesome`"  if id is 2 and data isnt "awesome"

  $scope.saveUser = (data, id) ->
    angular.extend data,
      id: id

    $http.post "/saveUser", data

  $scope.removeServicio = (index) ->
    $scope.items_de_servicios.splice index, 1

  $scope.addUser = ->
    $scope.inserted =
      servicio: null
      monto_establecido: 0
    $scope.items_de_servicios.push $scope.inserted

  isNumber = (n) ->
    not isNaN(parseFloat(n)) and isFinite(n)

  $scope.calcularTotal = ->   
    montos_establecidos = $scope.items_de_servicios.map (a) -> a.monto_establecido
    montos_establecidos.reduce ((a, b) -> a + b), 0
    

app.run ($httpBackend) ->
  $httpBackend.whenGET("/contadors/1/servicios.json").respond [
    {
      "contador_id": 1,
      "created_at": "2013-11-24T12:15:08Z",
      "descripcion": "Impuestos",
      "id": 1,
      "monto": "4000.0",
      "updated_at": "2013-11-24T12:15:08Z"
    }, {
      "contador_id": 1,
      "created_at": "2013-11-24T12:15:17Z",
      "descripcion": "Ganancias",
      "id": 2,
      "monto": "3400.0",
      "updated_at": "2013-11-24T12:15:17Z"
    }
  ]

  $httpBackend.whenGET("/groups").respond [
    id: 1
    descripcion: "user"
  ,
    id: 2
    descripcion: "customer"
  ,
    id: 3
    descripcion: "vip"
  ,
    id: 4
    descripcion: "admin"
  ]
  $httpBackend.whenPOST(/\/saveUser/).respond (method, url, data) ->
    data = angular.fromJson(data)
    [ 200,
      status: "ok"
     ]