      function smd_system_periodic()
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "global.fh"
#include "smd_system_data.fh"
c
      logical smd_system_periodic
c     
      character*32 pname,tag,sp_lattice
      logical result
c
      pname = "smd_system_periodic"
c
c      write(*,*) "in "//pname
c
c     get components
c     --------------
      tag = "lattice"
      call smd_system_get_component(sp_lattice,tag,result)
      
      smd_system_periodic = result
      return
      end

      function smd_system_shake()
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "global.fh"
#include "smd_system_data.fh"
c
      logical smd_system_shake
c     
      integer rtdb
      character*32 pname,tag,sp_lattice
      logical oshake,oshake_rtdb
c
      pname = "smd_system_shake"
c
      write(*,*) "in "//pname
c
c     get components
c     --------------
      tag = "shakelist"
      call smd_system_get_component(sp_lattice,tag,oshake)

      tag="smd:oshake"
      call smd_rtdb_get_handle(rtdb)
      if (.not.rtdb_get(rtdb,tag,mt_log,1,oshake_rtdb))
     >      oshake_rtdb=.true.

      
      smd_system_shake = oshake.and.oshake_rtdb
      return
      end

      function smd_system_ntot(ntot)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "util.fh"
#include "global.fh"
c     
      logical smd_system_ntot
      integer ntot
c
      character*72 tag,sp_atom
      character*30 pname
      integer i_iconst
      logical result

      pname = "smd_system_ntot"

      tag = "atom"
      call smd_system_get_component(sp_atom,tag,result)
      if(.not.result) goto 100

      call smd_atom_ntot(ntot)

100   continue
      smd_system_ntot = result
      return
      end

      function smd_system_nres(nr)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "util.fh"
#include "global.fh"
c     
      logical smd_system_nres
      integer nr
c
      character*72 tag,sp_atom
      character*30 pname
      integer i_iconst
      logical result

      pname = "smd_system_ntot"

      tag = "atom"
      call smd_system_get_component(sp_atom,tag,result)
      if(.not.result) goto 100

      call smd_atom_nres(sp_atom,nr)

100   continue
      smd_system_nres = result
      return
      end

      subroutine smd_system_ntcons(ntot)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "util.fh"
#include "global.fh"
c     
      integer ntot
c
      character*72 tag,sp_shakelist
      character*30 pname
      integer i_iconst
      logical result

      pname = "smd_system_nt"

      ntot = 0
      tag = "shakelist"
      call smd_system_get_component(sp_shakelist,tag,result)
      if(.not.result) then
        goto 100
      end if

      tag = "shake:distance"
      call smd_data_get_size(sp_shakelist,tag,ntot,result)
      if(.not.result)
     >  call errquit(
     >       pname//'failed size on '//tag,0,0)

100   continue
      return
      end

      function smd_system_tstep(t)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "global.fh"
#include "smd_system_data.fh"
c
      double precision t
      logical smd_system_tstep
c     
      character*32 pname,tag
      logical result
      integer rtdb
c
      pname = "smd_system_tstep"
c
      write(*,*) "in "//pname
c
      call smd_rtdb_get_handle(rtdb)
      tag="smd:step"
      result = rtdb_get(rtdb,tag,mt_dbl,1,t)
      
      smd_system_tstep = result
      return
      end

      function smd_system_ndata(nd)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "global.fh"
#include "smd_system_data.fh"
c
      integer nd
      logical smd_system_ndata
c     
      character*32 pname,tag
      logical result
      integer rtdb
c
      pname = "smd_system_ndata"
c
      write(*,*) "in "//pname
c
      call smd_rtdb_get_handle(rtdb)
      tag="smd:ndata"
      result = rtdb_get(rtdb,tag,mt_int,1,nd)
      
      smd_system_ndata = result
      return
      end
c $Id$
