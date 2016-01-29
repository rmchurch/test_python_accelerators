!file: test_f2py
! subroutine test_f2py(f,b,n,fnew)
subroutine test_f2py(f,b,fnew,n1,n2,n3,n4)

integer  :: n1,n2,n3,n4
real(8), dimension(n1,n2,n3,n4) :: f
real(8), dimension(n1,n4) :: b
real(8), dimension(n2,n3) :: fnew
!f2py intent(in) f
!f2py intent(in) b
!f2py intent(out) fnew
!f2py intent(in) n1
!f2py intent(in) n2
!f2py intent(in) n3
!f2py intent(in) n4

! integer, dimension(4) :: n
! real(8), dimension(n(1),n(2),n(3),n(4)) :: f
! real(8), dimension(n(1),n(4)) :: b
! real(8), dimension(n(2),n(3)) :: fnew

integer :: i1,i2,i3,i4

do i1=1,n1
	do i2=1,n2
		do i3=1,n3
			do i4=1,n4
				fnew(i2,i3) = fnew(i2,i3) + f(i1,i2,i3,i4)*b(i1,i4)
			enddo
		enddo
	enddo
enddo

end subroutine test_f2py



subroutine test_f2py_reorder(f,b,fnew,n1,n2,n3,n4)

integer  :: n1,n2,n3,n4
real(8), dimension(n1,n2,n3,n4) :: f
real(8), dimension(n3,n4) :: b
real(8), dimension(n1,n2) :: fnew
!f2py intent(in) f
!f2py intent(in) b
!f2py intent(out) fnew
!f2py intent(in) n1
!f2py intent(in) n2
!f2py intent(in) n3
!f2py intent(in) n4

! integer, dimension(4) :: n
! real(8), dimension(n(1),n(2),n(3),n(4)) :: f
! real(8), dimension(n(1),n(4)) :: b
! real(8), dimension(n(2),n(3)) :: fnew

integer :: i1,i2,i3,i4

do i3=1,n3
	do i4=1,n4
		do i1=1,n1
			do i2=1,n2
				fnew(i1,i2) = fnew(i1,i2) + f(i1,i2,i3,i4)*b(i3,i4)
			enddo
		enddo
	enddo
enddo

end subroutine test_f2py_reorder